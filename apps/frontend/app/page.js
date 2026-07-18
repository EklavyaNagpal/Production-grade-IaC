async function getHealth() {
  const base = process.env.NEXT_PUBLIC_API_BASE_URL || "http://localhost:8000";

  try {
    const res = await fetch(`${base}/health`, { cache: "no-store" });
    if (!res.ok) {
      return { status: "degraded" };
    }
    return res.json();
  } catch {
    return { status: "unreachable" };
  }
}

export default async function Home() {
  const health = await getHealth();

  return (
    <main style={{ fontFamily: "system-ui", padding: "2rem", maxWidth: "820px", margin: "0 auto" }}>
      <h1>Production Deployment Reference</h1>
      <p>Next.js frontend running in AWS.</p>
      <p>
        Backend health: <strong>{health.status || "unknown"}</strong>
      </p>
    </main>
  );
}
