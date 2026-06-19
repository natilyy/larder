# 🥫 Larder

A self-hosted **food inventory, meal planning and smart-shopping** system that lives on the
tablet stuck to your fridge, integrated with **Home Assistant**.

Track what's in the fridge/freezer/pantry, log usage by voice ("I used 500ml of milk"), get a
weekly shopping list that builds itself, scan barcodes to add items, track leftovers, cook with
step-by-step guidance, and see waste/cost stats — with AI meal planning coming later.

> Status: **early development** — built phase by phase.

## Stack

Full-stack **TypeScript**:

| Layer        | Choice                                                       |
|--------------|--------------------------------------------------------------|
| Backend      | Node.js · **NestJS** · **Prisma** ORM                        |
| Database     | **PostgreSQL** (relational data)                             |
| Frontend     | **Lit** custom Lovelace cards (HACS-installable)             |
| HA glue      | Built-in **REST integration** (YAML) — no Python needed      |
| Barcodes     | Client-side scan (ZXing-js) → **Open Food Facts** lookup     |
| AI (later)   | `@anthropic-ai/sdk` for structured-output meal planning      |
| Deploy       | Docker Compose → GHCR → Ubuntu homelab                       |

## Quick start (dev)

```bash
cp .env.example .env             # adjust if needed
npm install
docker compose up -d postgres    # start the database
npm run prisma:migrate           # after you've written prisma/schema.prisma
npm run start:dev                # http://localhost:3000  (Swagger at /api)
```

## License

MIT © 2026 natilyys
