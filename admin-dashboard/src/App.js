import { useState } from "react";
import Sidebar from "./components/Sidebar";
import OrdersPage from "./pages/OrdersPage";
import UsersPage from "./pages/UsersPage";
import ProductsPage from "./pages/ProductsPage";

function App() {
  const [currentTab, setCurrentTab] = useState("orders");
  return (
    <div style={{
      display: "flex",
      height: "100vh",
      fontFamily: "Segoe UI"
    }}>
      <Sidebar currentTab={currentTab} setCurrentTab={setCurrentTab} />

      <div style={{
        width: "80%",
        padding: 20,
        background: "#f5f7fb",
        overflowY: "auto"
      }}>
        {currentTab === "users" && <UsersPage />}
        {currentTab === "products" && <ProductsPage />}
        {currentTab === "orders" && <OrdersPage />}
      </div>
    </div>
  );
}

export default App;