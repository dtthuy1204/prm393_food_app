import FastfoodIcon from "@mui/icons-material/Fastfood";
import PeopleAltRoundedIcon from "@mui/icons-material/PeopleAltRounded";
import Inventory2RoundedIcon from "@mui/icons-material/Inventory2Rounded";
import RestaurantMenuRoundedIcon from "@mui/icons-material/RestaurantMenuRounded";
import React from "react";

export default function Sidebar({ currentTab, setCurrentTab }) {
  const menu = [
  { key: "users", label: "Users", icon: <PeopleAltRoundedIcon /> },
  { key: "orders", label: "Orders", icon: <Inventory2RoundedIcon /> },
  { key: "products", label: "Products", icon: <RestaurantMenuRoundedIcon /> },
];

  return (
    <div style={sidebarStyle}>
      
      {/* TOP */}
      <div style={{ overflow: "hidden" }}>
        
        {/* LOGO */}
        <div style={logoContainer}>
          <div style={logoIcon}>
            <FastfoodIcon style={{ color: "white", fontSize: 22 }} />
          </div>

          <div style={{ minWidth: 0 }}>
            <div style={logoText}>Food Admin</div>
            <div style={logoSub}>Dashboard</div>
          </div>
        </div>

        {/* MENU */}
        {menu.map(item => {
          const active = currentTab === item.key;

          return (
            <div
              key={item.key}
              onClick={() => setCurrentTab(item.key)}
              style={{
                ...menuItem,
                ...(active && activeItem)
              }}
            >
              <span style={{ display: "flex", alignItems: "center" }}>
  {React.cloneElement(item.icon, { style: iconStyle(active) })}
</span>

              <span style={{
                whiteSpace: "nowrap",
                overflow: "hidden",
                textOverflow: "ellipsis"
              }}>
                {item.label}
              </span>
            </div>
          );
        })}
      </div>

      {/* BOTTOM */}
      <div style={userBox}>
        <p style={{ margin: 0, fontWeight: "bold" }}>Admin</p>

        <p style={emailStyle}>
          dinhthuy2004vk@gmail.com
        </p>
      </div>
    </div>
  );
}


const sidebarStyle = {
  width: 260,
  height: "100vh",
  background: "linear-gradient(180deg, #FFE0E9, #FFF5F7)",
  padding: 20,
  borderRight: "1px solid #f3d1d9",
  display: "flex",
  flexDirection: "column",
  justifyContent: "space-between",
  boxSizing: "border-box"
};

const logoContainer = {
  marginBottom: 30,
  display: "flex",
  alignItems: "center",
  gap: 10,
  minWidth: 0
};

const logoIcon = {
  width: 42,
  height: 42,
  borderRadius: 12,
  background: "linear-gradient(135deg,#FF9A9E,#FAD0C4)",
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  flexShrink: 0 
};

const logoText = {
  fontWeight: "bold",
  whiteSpace: "nowrap",
  overflow: "hidden",
  textOverflow: "ellipsis"
};

const logoSub = {
  fontSize: 12,
  color: "#999",
  whiteSpace: "nowrap",
  overflow: "hidden",
  textOverflow: "ellipsis"
};

const menuItem = {
  display: "flex",
  alignItems: "center",
  gap: 10,
  padding: "12px 14px",
  marginBottom: 8,
  cursor: "pointer",
  borderRadius: 12,
  color: "#444",
  transition: "all 0.2s",
};

const iconStyle = (active) => ({
  color: active ? "white" : "#666",
  fontSize: 20
});

const activeItem = {
  fontWeight: "bold",
  background: "linear-gradient(135deg,#FF9A9E,#FAD0C4)",
  color: "white",
  boxShadow: "0 4px 12px rgba(255,154,158,0.4)"
};

const userBox = {
  padding: 12,
  borderRadius: 12,
  background: "white",
  boxShadow: "0 2px 10px rgba(0,0,0,0.05)"
};

const emailStyle = {
  margin: 0,
  fontSize: 12,
  color: "#999",
  whiteSpace: "nowrap",
  overflow: "hidden",
  textOverflow: "ellipsis"
};