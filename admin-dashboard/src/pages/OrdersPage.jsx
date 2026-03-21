import { useEffect, useState } from "react";
import { collection, onSnapshot } from "firebase/firestore";
import { db } from "../firebase";
import OrderCard from "../components/OrderCard";

// ✅ import icon MUI
import Inventory2Icon from "@mui/icons-material/Inventory2";
import AllInboxIcon from "@mui/icons-material/AllInbox";
import HourglassBottomIcon from "@mui/icons-material/HourglassBottom";
import LocalShippingIcon from "@mui/icons-material/LocalShipping";
import CheckCircleIcon from "@mui/icons-material/CheckCircle";

export default function OrdersPage() {
  const [orders, setOrders] = useState([]);
  const [filter, setFilter] = useState("all");

  useEffect(() => {
    const unsubscribe = onSnapshot(collection(db, "orders"), (snapshot) => {
      const data = snapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data(),
      }));
      setOrders(data);
    });

    return () => unsubscribe();
  }, []);

  const filteredOrders =
    filter === "all"
      ? orders
      : orders.filter(o => o.status === filter);

  const stats = {
    all: orders.length,
    pending: orders.filter(o => o.status === "pending").length,
    delivering: orders.filter(o => o.status === "delivering").length,
    done: orders.filter(o => o.status === "done").length,
  };

  return (
    <div style={{
      padding: 20,
      background: "#FFF5F7",
      minHeight: "100vh"
    }}>
      
      {/* HEADER */}
      <h2 style={{
        marginBottom: 20,
        display: "flex",
        alignItems: "center",
        gap: 10
      }}>
        <Inventory2Icon /> Order Management
      </h2>

      {/* ===== STATS ===== */}
      <div style={statsGrid}>
        <StatCard icon={<AllInboxIcon />} label="All Orders" value={stats.all} />
        <StatCard icon={<HourglassBottomIcon />} label="Pending" value={stats.pending} />
        <StatCard icon={<LocalShippingIcon />} label="Delivering" value={stats.delivering} />
        <StatCard icon={<CheckCircleIcon />} label="Done" value={stats.done} />
      </div>

      {/* ===== FILTER BUTTONS ===== */}
      <div style={filterRow}>
        {[
          { key: "all", icon: <AllInboxIcon /> },
          { key: "pending", icon: <HourglassBottomIcon /> },
          { key: "delivering", icon: <LocalShippingIcon /> },
          { key: "done", icon: <CheckCircleIcon /> },
        ].map(f => (
          <button
            key={f.key}
            onClick={() => setFilter(f.key)}
            style={{
              ...filterBtn,
              background:
                filter === f.key
                  ? "linear-gradient(135deg,#FF9A9E,#FAD0C4)"
                  : "#fff",
              color: filter === f.key ? "#fff" : "#333"
            }}
          >
            <span style={{ display: "flex", alignItems: "center", gap: 6 }}>
              {f.icon}
              {f.key.toUpperCase()}
            </span>
          </button>
        ))}
      </div>

      {/* EMPTY */}
      {filteredOrders.length === 0 && (
        <div style={emptyStyle}>
          No orders yet...
        </div>
      )}

      {/* ===== GRID ===== */}
      <div style={grid}>
        {filteredOrders.map(order => (
          <div key={order.id} style={orderWrapper}>
            <OrderCard order={order} />
          </div>
        ))}
      </div>
    </div>
  );
}

// ✅ StatCard có icon
function StatCard({ label, value, icon }) {
  return (
    <div style={statCard}>
      <div style={{ marginBottom: 6 }}>{icon}</div>
      <p style={{ fontSize: 13, color: "#888" }}>{label}</p>
      <h3>{value}</h3>
    </div>
  );
}

/* ================= STYLE ================= */

const statsGrid = {
  display: "grid",
  gridTemplateColumns: "repeat(4, 1fr)",
  gap: 15,
  marginBottom: 20
};

const statCard = {
  background: "#fff",
  padding: 15,
  borderRadius: 14,
  boxShadow: "0 4px 15px rgba(255,154,158,0.2)",
  textAlign: "center"
};

const filterRow = {
  display: "flex",
  gap: 10,
  marginBottom: 20,
  flexWrap: "wrap"
};

const filterBtn = {
  padding: "8px 14px",
  borderRadius: 10,
  border: "none",
  cursor: "pointer",
  fontWeight: "bold",
  boxShadow: "0 2px 8px rgba(0,0,0,0.05)",
  display: "flex",
  alignItems: "center"
};

const grid = {
  display: "grid",
  gridTemplateColumns: "repeat(auto-fill, minmax(320px, 1fr))",
  gap: 20
};

const orderWrapper = {
  background: "#fff",
  borderRadius: 16,
  padding: 10,
  boxShadow: "0 4px 15px rgba(0,0,0,0.08)"
};

const emptyStyle = {
  textAlign: "center",
  padding: 50,
  color: "#888"
};