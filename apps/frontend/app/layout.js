export const metadata = {
  title: "CD Assessment Frontend",
  description: "Next.js frontend"
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
