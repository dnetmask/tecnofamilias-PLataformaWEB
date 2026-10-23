-- CreateEnum
CREATE TYPE "ServiceAudience" AS ENUM ('FAMILIAS', 'COLEGIOS', 'EMPRESAS', 'GOBIERNO');

-- CreateEnum
CREATE TYPE "ServiceRequestStatus" AS ENUM ('NEW', 'PAID', 'CONTACTED', 'WON', 'LOST');

-- AlterEnum
ALTER TYPE "OrderKind" ADD VALUE 'SERVICE';

-- AlterTable
ALTER TABLE "Order" ADD COLUMN     "serviceId" TEXT;

-- CreateTable
CREATE TABLE "Service" (
    "id" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "audience" "ServiceAudience" NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT '',
    "details" TEXT NOT NULL DEFAULT '',
    "priceCop" INTEGER,
    "priceLabel" TEXT NOT NULL,
    "unit" TEXT NOT NULL DEFAULT '',
    "featured" BOOLEAN NOT NULL DEFAULT false,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "order" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Service_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ServiceRequest" (
    "id" TEXT NOT NULL,
    "serviceId" TEXT NOT NULL,
    "userId" TEXT,
    "orderId" TEXT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL DEFAULT '',
    "organization" TEXT NOT NULL DEFAULT '',
    "city" TEXT NOT NULL DEFAULT '',
    "message" TEXT NOT NULL DEFAULT '',
    "status" "ServiceRequestStatus" NOT NULL DEFAULT 'NEW',
    "adminNotes" TEXT NOT NULL DEFAULT '',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ServiceRequest_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Service_slug_key" ON "Service"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "ServiceRequest_orderId_key" ON "ServiceRequest"("orderId");

-- CreateIndex
CREATE INDEX "ServiceRequest_status_createdAt_idx" ON "ServiceRequest"("status", "createdAt");

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServiceRequest" ADD CONSTRAINT "ServiceRequest_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServiceRequest" ADD CONSTRAINT "ServiceRequest_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- Servicios de la presentación (valores de referencia; se editan en /admin/servicios).
INSERT INTO "Service" ("id", "slug", "audience", "name", "description", "details", "priceCop", "priceLabel", "unit", "featured", "active", "order") VALUES
('svc_asesoria', 'asesoria-personalizada', 'FAMILIAS', 'Asesoría personalizada', 'Acompañamiento de alto valor durante un mes: diagnóstico del hogar, configuración de dispositivos y seguimiento.', 'Ideal si ya hubo un incidente o necesitas ayuda urgente. Después del pago te contactamos para agendar la primera sesión.', 1000000, 'COP 1.000.000', 'por familia · 1 mes', true, true, 1),
('svc_colegio_masterclass', 'colegios-masterclass-institucional', 'COLEGIOS', 'Masterclass institucional', 'Sesión general para padres, docentes o estudiantes, hasta 80 asistentes.', '', NULL, 'COP 3–5 M', 'por sesión', false, true, 10),
('svc_colegio_programa', 'colegios-programa-anual', 'COLEGIOS', 'Programa anual', '4 masterclass por edad, plataforma para todas las familias e informe al rector.', '', NULL, 'COP 12–20 M', 'por año', true, true, 11),
('svc_empresa_sesion', 'empresas-sesion-empleados', 'EMPRESAS', 'Sesión para empleados', 'Sesión general de bienestar digital para padres, presencial o virtual.', '', NULL, 'COP 4–6 M', 'por sesión', false, true, 20),
('svc_empresa_programa', 'empresas-programa-bienestar', 'EMPRESAS', 'Programa de bienestar', 'Masterclass trimestrales, plataforma para los hogares y 5 asesorías incluidas.', '', NULL, 'COP 20–25 M', 'por año', true, true, 21),
('svc_alcaldia', 'alcaldias-programa-social', 'GOBIERNO', 'Alcaldía', 'Programa de seguridad digital familiar para un municipio intermedio, en 5 a 10 colegios públicos: masterclass a padres, docentes y estudiantes, más acceso a la plataforma.', 'Contratación por proceso público en SECOP II, con informe de cobertura e indicadores de impacto al cierre. Alineado con el plan de desarrollo y de convivencia escolar.', NULL, 'COP 60–150 M', 'por programa anual', false, true, 30),
('svc_gobernacion', 'gobernaciones-programa-departamental', 'GOBIERNO', 'Gobernación', 'Programa departamental en varios municipios, con configuración técnica, seguimiento y medición de impacto.', 'Contratación por proceso público en SECOP II, con informe de cobertura e indicadores de impacto al cierre.', NULL, 'COP 200–500 M', 'por programa anual', true, true, 31)
ON CONFLICT ("slug") DO NOTHING;
