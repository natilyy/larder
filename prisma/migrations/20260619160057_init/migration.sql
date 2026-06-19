-- CreateEnum
CREATE TYPE "Unit" AS ENUM ('g', 'ml', 'unit');

-- CreateEnum
CREATE TYPE "UsageReason" AS ENUM ('used', 'binned');

-- CreateEnum
CREATE TYPE "Source" AS ENUM ('voice', 'manual', 'scan');

-- CreateTable
CREATE TABLE "Product" (
    "id" TEXT NOT NULL,
    "barcode" TEXT,
    "name" TEXT NOT NULL,
    "brand" TEXT,
    "category" TEXT,
    "defaultUnit" "Unit" NOT NULL,
    "kcalPer100" DOUBLE PRECISION,
    "proteinPer100" DOUBLE PRECISION,
    "carbsPer100" DOUBLE PRECISION,
    "fatPer100" DOUBLE PRECISION,
    "typicalPrice" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InventoryItem" (
    "id" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "locationId" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "unit" "Unit" NOT NULL,
    "expireDate" TIMESTAMP(3),
    "openedAt" TIMESTAMP(3),
    "isLeftover" BOOLEAN NOT NULL DEFAULT false,
    "pricePaid" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InventoryItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Location" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UsageLog" (
    "id" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "productName" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "unit" "Unit" NOT NULL,
    "reason" "UsageReason" NOT NULL DEFAULT 'used',
    "source" "Source" NOT NULL DEFAULT 'manual',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UsageLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ParLevel" (
    "id" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "minQuantity" DOUBLE PRECISION NOT NULL,
    "unit" "Unit" NOT NULL,

    CONSTRAINT "ParLevel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShoppingListItem" (
    "id" TEXT NOT NULL,
    "productId" TEXT,
    "name" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION,
    "unit" TEXT,
    "purchased" BOOLEAN NOT NULL DEFAULT false,
    "autoAdded" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ShoppingListItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Product_barcode_key" ON "Product"("barcode");

-- CreateIndex
CREATE UNIQUE INDEX "Location_name_key" ON "Location"("name");

-- CreateIndex
CREATE UNIQUE INDEX "ParLevel_productId_key" ON "ParLevel"("productId");

-- AddForeignKey
ALTER TABLE "InventoryItem" ADD CONSTRAINT "InventoryItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventoryItem" ADD CONSTRAINT "InventoryItem_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParLevel" ADD CONSTRAINT "ParLevel_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
