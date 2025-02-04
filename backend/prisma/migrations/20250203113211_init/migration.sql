-- CreateEnum
CREATE TYPE "PlayerState" AS ENUM ('online', 'offline', 'deleted', 'banned');

-- CreateEnum
CREATE TYPE "GameState" AS ENUM ('ongoing', 'finished', 'waiting', 'cancelled');

-- CreateEnum
CREATE TYPE "messageStatus" AS ENUM ('sent', 'deleted', 'removed');

-- CreateEnum
CREATE TYPE "roomStatus" AS ENUM ('active', 'inactive', 'deleted');

-- CreateTable
CREATE TABLE "Player" (
    "id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "position" JSONB NOT NULL,
    "playerState" "PlayerState" NOT NULL,

    CONSTRAINT "Player_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Avatar" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "appearanceData" JSONB NOT NULL,

    CONSTRAINT "Avatar_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Game" (
    "id" TEXT NOT NULL,
    "whiteId" TEXT NOT NULL,
    "blackId" TEXT NOT NULL,
    "gameState" "GameState" NOT NULL,
    "winnerId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Game_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Room" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "max_length" JSONB NOT NULL,
    "roomStatus" "roomStatus" NOT NULL,

    CONSTRAINT "Room_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Message" (
    "id" TEXT NOT NULL,
    "senderId" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "messageStatus" "messageStatus" NOT NULL,

    CONSTRAINT "Message_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Player_username_key" ON "Player"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Avatar_playerId_key" ON "Avatar"("playerId");

-- AddForeignKey
ALTER TABLE "Avatar" ADD CONSTRAINT "Avatar_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Game" ADD CONSTRAINT "Game_whiteId_fkey" FOREIGN KEY ("whiteId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Game" ADD CONSTRAINT "Game_blackId_fkey" FOREIGN KEY ("blackId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Game" ADD CONSTRAINT "Game_winnerId_fkey" FOREIGN KEY ("winnerId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "Player"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
