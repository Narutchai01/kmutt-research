import Navbar from "./Navbar";
const Layout = ({ children }: { children: React.ReactNode }) => {
  return (
    <>
      <div className="grid grid-cols-[1fr_5fr]">
        <Navbar />
        {children}
      </div>
    </>
  );
};

export default Layout;
