import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Requerido por el stage "runner" del Dockerfile (copia .next/standalone)
  output: "standalone",
  experimental: {
    serverActions: {
      bodySizeLimit: "25mb",
    },
    proxyClientMaxBodySize: "25mb",
  },
};

export default nextConfig;
