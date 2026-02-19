last-store/
│
├── frontend/
│   ├── app/
│   │   ├── page.tsx
│   │   ├── login/page.tsx
│   │   ├── register/page.tsx
│   │   ├── publish/page.tsx
│   │   ├── ad/[id]/page.tsx
│   │   ├── dashboard/page.tsx
│   │   └── admin/page.tsx
│   │
│   ├── components/
│   │   ├── Navbar.tsx
│   │   ├── Footer.tsx
│   │   ├── AdCard.tsx
│   │   ├── CategoryCard.tsx
│   │   └── SearchBar.tsx
│   │
│   ├── styles/
│   ├── lib/api.ts
│   └── public/
│
├── backend/
│   ├── src/
│   │   ├── routes/
│   │   │   ├── auth.routes.js
│   │   │   ├── ads.routes.js
│   │   │   └── users.routes.js
│   │   │
│   │   ├── controllers/
│   │   ├── middleware/
│   │   ├── models/
│   │   ├── config/db.js
│   │   └── server.js
│
├── database/
│   └── schema.sql
│
├── docs/
│   ├── api.md
│   └── roadmap.md
│
├── .env.example
├── README.md
└── LICENSE
# ==============================
# BACKEND (Node + Express)
# ==============================

# backend/server.js
import express from "express";
import cors from "cors";

const app = express();
app.use(cors());
app.use(express.json());

const ads = [
  {
    id: 1,
    title: "Cuenta 1.2B Might T5",
    price: 350,
    might: "1.2B",
    castle: 25,
    image: "https://i.imgur.com/4ZQZ4Zy.png"
  },
  {
    id: 2,
    title: "Cuenta 800M Might T4",
    price: 180,
    might: "800M",
    castle: 25,
    image: "https://i.imgur.com/4ZQZ4Zy.png"
  },
  {
    id: 3,
    title: "Servicio Rally Trap",
    price: 50,
    might: "N/A",
    castle: "N/A",
    image: "https://i.imgur.com/4ZQZ4Zy.png"
  }
];

app.get("/api/ads", (req, res) => {
  res.json(ads);
});

app.get("/api/ads/featured", (req, res) => {
  res.json(ads.slice(0, 2));
});

app.listen(4000, () => {
  console.log("Backend running on http://localhost:4000");
});

# ==============================
# FRONTEND (Next.js App Router)
# ==============================

# frontend/app/page.tsx
import AdCard from "./AdCard";

async function getAds() {
  const res = await fetch("http://localhost:4000/api/ads", {
    cache: "no-store",
  });
  return res.json();
}

async function getFeaturedAds() {
  const res = await fetch("http://localhost:4000/api/ads/featured", {
    cache: "no-store",
  });
  return res.json();
}

export default async function Home() {
  const ads = await getAds();
  const featured = await getFeaturedAds();

  return (
    <main style={{ background: "#0b1220", minHeight: "100vh", padding: "40px" }}>
      <h1 style={{ color: "#facc15", fontSize: "32px" }}>
        Last Store – Lords Mobile
      </h1>

      <h2 style={{ color: "white", marginTop: "40px" }}>
        Anuncios destacados
      </h2>
      <div style={{ display: "flex", gap: "20px" }}>
        {featured.map((ad) => (
          <AdCard key={ad.id} ad={ad} />
        ))}
      </div>

      <h2 style={{ color: "white", marginTop: "40px" }}>
        Últimos anuncios
      </h2>
      <div style={{ display: "flex", gap: "20px", flexWrap: "wrap" }}>
        {ads.map((ad) => (
          <AdCard key={ad.id} ad={ad} />
        ))}
      </div>
    </main>
  );
}

# ==============================
# COMPONENTE AD CARD
# ==============================

# frontend/app/AdCard.tsx
export default function AdCard({ ad }) {
  return (
    <div
      style={{
        background: "#020617",
        borderRadius: "12px",
        padding: "16px",
        width: "220px",
        color: "white",
      }}
    >
      <img
        src={ad.image}
        style={{ width: "100%", borderRadius: "8px" }}
      />
      <h3>{ad.title}</h3>
      <p style={{ color: "#facc15", fontWeight: "bold" }}>
        ${ad.price}
      </p>
      <p style={{ fontSize: "12px", color: "#9ca3af" }}>
        Might: {ad.might} | Castle: {ad.castle}
      </p>
      <button
        style={{
          marginTop: "10px",
          width: "100%",
          padding: "8px",
          background: "#facc15",
          border: "none",
          borderRadius: "6px",
          cursor: "pointer",
        }}
      >
        Ver anuncio
      </button>
    </div>
  );
}

