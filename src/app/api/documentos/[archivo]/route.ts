import { promises as fs } from 'fs';
import path from 'path';
import { NextResponse } from 'next/server';

// Sirve los PDFs del módulo Documentos desde el storage local.
// El proxy de auth ya exige sesión para /api/documentos/* (solo /api/auth es libre).

const STORAGE_DIR = path.resolve(
    process.cwd(),
    process.env.STORAGE_DOCUMENTS_PATH || './storage/documentos',
);

export async function GET(
    _request: Request,
    { params }: { params: Promise<{ archivo: string }> },
) {
    const { archivo } = await params;
    // path.basename bloquea cualquier intento de path traversal
    const fileName = path.basename(decodeURIComponent(archivo));
    if (!fileName) {
        return new NextResponse('No encontrado', { status: 404 });
    }

    try {
        const data = await fs.readFile(path.join(STORAGE_DIR, fileName));
        return new NextResponse(new Uint8Array(data), {
            headers: {
                'Content-Type': 'application/pdf',
                'Content-Disposition': `inline; filename="${fileName}"`,
                'Cache-Control': 'private, max-age=3600',
            },
        });
    } catch {
        return new NextResponse('No encontrado', { status: 404 });
    }
}
