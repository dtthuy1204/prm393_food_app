import { doc, updateDoc } from "firebase/firestore";
import { db } from "../firebase";

export default function OrderCard({ order }) {

  const updateStatus = async (status) => {
    await updateDoc(doc(db, "orders", order.id), {
      status: status,
    });
  };

  const statusColor = {
    pending: "#f0ad4e",
    delivering: "#5bc0de",
    done: "#5cb85c"
  };

  return (
    <div style={{
      background: "#fff",
      borderRadius: 16,
      padding: 15,
      boxShadow: "0 4px 15px rgba(0,0,0,0.08)",
      display: "flex",
      flexDirection: "column",
      justifyContent: "space-between",
      minHeight: 260
    }}>

      {/* TOP */}
      <div>
        <p style={{ fontSize: 13, color: "#999" }}>
          ID: {order.id.slice(0, 10)}...
        </p>

        <p><b> Address:</b> {order.address}</p>

        <p>
          <b> Total:</b>{" "}
          <span style={{ color: "#ff4d4f", fontWeight: "bold" }}>
            ${order.totalPrice}
          </span>
        </p>

        {/* STATUS */}
        <p>
          <b>Status:</b>{" "}
          <span style={{
            background: statusColor[order.status] || "#ccc",
            color: "white",
            padding: "4px 10px",
            borderRadius: 20,
            fontSize: 12
          }}>
            {order.status}
          </span>
        </p>

        {/* ITEMS */}
        <div style={{ marginTop: 10 }}>
          <b>Items:</b>
          <ul style={{
            paddingLeft: 18,
            maxHeight: 80,
            overflowY: "auto",
            fontSize: 13
          }}>
            {order.items?.map((item, index) => (
              <li key={index}>
                {item.name} x {item.quantity}
              </li>
            ))}
          </ul>
        </div>
      </div>

      {/* BUTTONS */}
      <div style={{
        display: "flex",
        gap: 8,
        marginTop: 15
      }}>
        <button
          onClick={() => updateStatus("pending")}
          style={btnStyle("#f0ad4e")}
        >
          Pending
        </button>

        <button
          onClick={() => updateStatus("delivering")}
          style={btnStyle("#5bc0de")}
        >
          Delivering
        </button>

        <button
          onClick={() => updateStatus("done")}
          style={btnStyle("#5cb85c")}
        >
          Done
        </button>
      </div>
    </div>
  );
}

const btnStyle = (color) => ({
  flex: 1,
  height: 40,
  border: "none",
  borderRadius: 8,
  background: color,
  color: "white",
  cursor: "pointer",
  fontSize: 16,
});