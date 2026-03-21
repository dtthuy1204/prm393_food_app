import { useEffect, useState } from "react";
import { collection, onSnapshot } from "firebase/firestore";
import { db } from "../firebase";

import PeopleAltRoundedIcon from "@mui/icons-material/PeopleAltRounded";
import AdminPanelSettingsRoundedIcon from "@mui/icons-material/AdminPanelSettingsRounded";
import PersonRoundedIcon from "@mui/icons-material/PersonRounded";
import SearchRoundedIcon from "@mui/icons-material/SearchRounded";

export default function UsersPage() {
  const [users, setUsers] = useState([]);
  const [search, setSearch] = useState("");
  const [roleFilter, setRoleFilter] = useState("all");

  useEffect(() => {
    const unsub = onSnapshot(collection(db, "users"), (snapshot) => {
      setUsers(
        snapshot.docs.map(doc => ({
          id: doc.id,
          ...doc.data()
        }))
      );
    });

    return () => unsub();
  }, []);

  const filteredUsers = users.filter(user => {
    const matchSearch = user.email
      ?.toLowerCase()
      .includes(search.toLowerCase());

    const matchRole =
      roleFilter === "all" || user.role === roleFilter;

    return matchSearch && matchRole;
  });

  const stats = {
    total: users.length,
    admin: users.filter(u => u.role === "admin").length,
    user: users.filter(u => u.role === "user").length
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
        <PeopleAltRoundedIcon /> User Management
      </h2>

      {/* ===== STATS ===== */}
      <div style={statsGrid}>
        <StatCard icon={<PeopleAltRoundedIcon />} label="Total Users" value={stats.total} />
        <StatCard icon={<AdminPanelSettingsRoundedIcon />} label="Admins" value={stats.admin} />
        <StatCard icon={<PersonRoundedIcon />} label="Users" value={stats.user} />
      </div>

      {/* ===== SEARCH + FILTER ===== */}
      <div style={topBar}>
        <div style={{ position: "relative" }}>
          <SearchRoundedIcon style={{
            position: "absolute",
            top: 10,
            left: 10,
            color: "#aaa"
          }} />

          <input
            placeholder="Search email..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            style={{
              ...searchInput,
              paddingLeft: 35
            }}
          />
        </div>

        <div style={{ display: "flex", gap: 10 }}>
          {["all", "user", "admin"].map(r => (
            <button
              key={r}
              onClick={() => setRoleFilter(r)}
              style={{
                ...filterBtn,
                background:
                  roleFilter === r
                    ? "linear-gradient(135deg,#FF9A9E,#FAD0C4)"
                    : "#fff",
                color: roleFilter === r ? "#fff" : "#333"
              }}
            >
              {r.toUpperCase()}
            </button>
          ))}
        </div>
      </div>

      {/* EMPTY */}
      {filteredUsers.length === 0 && (
        <div style={emptyStyle}>
          No users found...
        </div>
      )}

      {/* ===== GRID ===== */}
      <div style={grid}>
        {filteredUsers.map(user => (
          <div key={user.id} style={card}>

            {/* AVATAR */}
            <div style={avatar}>
              {user.email?.charAt(0).toUpperCase()}
            </div>

            {/* INFO */}
            <div style={{ flex: 1 }}>
              <p style={email}>{user.email}</p>

              <span style={{
                ...roleTag,
                background:
                  user.role === "admin"
                    ? "#FF8A8A"
                    : "#7ED6DF"
              }}>
                {user.role}
              </span>
            </div>

            {/* DATE */}
            {user.createdAt && (
              <p style={date}>
                📅 {new Date(
                  user.createdAt.seconds * 1000
                ).toLocaleDateString()}
              </p>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}

function StatCard({ icon, label, value }) {
  return (
    <div style={statCard}>
      <div style={{ marginBottom: 5 }}>{icon}</div>
      <p style={{ fontSize: 13, color: "#888" }}>{label}</p>
      <h3>{value}</h3>
    </div>
  );
}

const statsGrid = {
  display: "grid",
  gridTemplateColumns: "repeat(3, 1fr)",
  gap: 15,
  marginBottom: 20
};

const statCard = {
  background: "#fff",
  padding: 15,
  borderRadius: 14,
  textAlign: "center",
  boxShadow: "0 4px 15px rgba(255,154,158,0.2)"
};

const topBar = {
  display: "flex",
  justifyContent: "space-between",
  alignItems: "center",
  marginBottom: 20,
  flexWrap: "wrap",
  gap: 10
};

const searchInput = {
  padding: "10px 14px",
  borderRadius: 12,
  border: "1px solid #f3d1d9",
  outline: "none",
  minWidth: 250
};

const filterBtn = {
  padding: "8px 14px",
  borderRadius: 10,
  border: "none",
  cursor: "pointer",
  fontWeight: "bold",
  boxShadow: "0 2px 8px rgba(0,0,0,0.05)"
};

const grid = {
  display: "grid",
  gridTemplateColumns: "repeat(auto-fill, minmax(260px, 1fr))",
  gap: 20
};

const card = {
  background: "#fff",
  borderRadius: 16,
  padding: 15,
  boxShadow: "0 4px 15px rgba(0,0,0,0.08)",
  display: "flex",
  flexDirection: "column",
  gap: 10
};

const avatar = {
  width: 50,
  height: 50,
  borderRadius: "50%",
  background: "linear-gradient(135deg,#FF9A9E,#FAD0C4)",
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  color: "white",
  fontWeight: "bold",
  fontSize: 18
};

const email = {
  fontWeight: "bold",
  marginBottom: 5
};

const roleTag = {
  padding: "4px 10px",
  borderRadius: 20,
  fontSize: 12,
  color: "white"
};

const date = {
  fontSize: 12,
  color: "#999"
};

const emptyStyle = {
  textAlign: "center",
  padding: 50,
  color: "#888"
};