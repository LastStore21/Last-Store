export default function AdCard({ ad }) {
  return (
    <div className="bg-slate-900 rounded-xl p-4 hover:scale-105 transition">
      <img src={ad.image} className="rounded-lg mb-3" />
      <h3 className="text-white font-bold">{ad.title}</h3>
      <p className="text-yellow-400 font-semibold">${ad.price}</p>
      <div className="text-sm text-gray-400">
        <span>Might: {ad.might}</span> · <span>Castle {ad.castle}</span>
      </div>
      <button className="mt-3 w-full bg-yellow-400 text-black rounded-lg py-2">
        Ver anuncio
      </button>
    </div>
  );
}
