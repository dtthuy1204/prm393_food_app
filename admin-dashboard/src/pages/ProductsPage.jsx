import { useEffect, useState } from "react";
import {
  collection,
  onSnapshot,
  addDoc,
  deleteDoc,
  doc,
  updateDoc
} from "firebase/firestore";
import { db } from "../firebase";

import RestaurantMenuRoundedIcon from "@mui/icons-material/RestaurantMenuRounded";
import AddIcon from "@mui/icons-material/Add";
import EditIcon from "@mui/icons-material/Edit";
import DeleteIcon from "@mui/icons-material/Delete";

export default function ProductsPage() {
  const [products, setProducts] = useState([]);

  const [form, setForm] = useState({
    name: "",
    price: "",
    category: "burgers",
    description: "",
    imagePath: "",
    addons: "",
  });

  const [editingId, setEditingId] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 15;

  useEffect(() => {
    const unsub = onSnapshot(collection(db, "products"), (snapshot) => {
      setProducts(
        snapshot.docs.map(doc => ({
          id: doc.id,
          ...doc.data(),
        }))
      );
    });

    return () => unsub();
  }, []);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async () => {
    if (!form.name || !form.price) return alert("Nhập đủ info");

    const data = {
      name: form.name,
      price: Number(form.price),
      category: form.category,
      description: form.description,
      imagePath: form.imagePath,
      addons: form.addons
        ? form.addons.split(",").map(a => ({
            name: a.trim(),
            price: 0
          }))
        : [],
    };

    if (editingId) {
      await updateDoc(doc(db, "products", editingId), data);
      setEditingId(null);
    } else {
      await addDoc(collection(db, "products"), data);
    }

    setForm({
      name: "",
      price: "",
      category: "burgers",
      description: "",
      imagePath: "",
      addons: "",
    });
  };

  const deleteProduct = async (id) => {
    await deleteDoc(doc(db, "products", id));
  };

  const editProduct = (p) => {
    setForm({
      name: p.name,
      price: p.price,
      category: p.category,
      description: p.description,
      imagePath: p.imagePath,
      addons: p.addons?.map(a => a.name).join(", "),
    });
    setEditingId(p.id);
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  const startIndex = (currentPage - 1) * itemsPerPage;
  const currentProducts = products.slice(startIndex, startIndex + itemsPerPage);
  const totalPages = Math.ceil(products.length / itemsPerPage);

  return (
    <div style={{ padding: 20, background: "#FFF5F7", minHeight: "100vh" }}>
      
      {/* HEADER */}
      <h2 style={{
        marginBottom: 20,
        display: "flex",
        alignItems: "center",
        gap: 10
      }}>
        <RestaurantMenuRoundedIcon /> Product Management
      </h2>

      {/* FORM */}
      <div style={cardStyle}>
        <h3 style={{ marginBottom: 15 }}>
          {editingId ? "Update Product" : "Add Product"}
        </h3>

        <div style={gridForm}>
          <input name="name" placeholder="Name" value={form.name} onChange={handleChange} style={inputStyle} />
          <input name="price" type="number" placeholder="Price" value={form.price} onChange={handleChange} style={inputStyle} />

          <select name="category" value={form.category} onChange={handleChange} style={inputStyle}>
            <option value="burgers">Burgers</option>
            <option value="salads">Salads</option>
            <option value="sides">Sides</option>
            <option value="desserts">Desserts</option>
            <option value="drinks">Drinks</option>
          </select>

          <input name="imagePath" placeholder="/images/..." value={form.imagePath} onChange={handleChange} style={inputStyle} />

          <input name="addons" placeholder="cheese, bacon..." value={form.addons} onChange={handleChange} style={inputStyle} />

          <textarea
            name="description"
            placeholder="Description"
            value={form.description}
            onChange={handleChange}
            style={{ ...inputStyle, gridColumn: "span 2", height: 80 }}
          />
        </div>

        <button onClick={handleSubmit} style={btnStyle}>
          <AddIcon />
          {editingId ? " Update" : " Add"}
        </button>
      </div>

      {/* LIST */}
      <div style={gridProducts}>
        {currentProducts.map(p => (
          <div key={p.id} style={productCard}>

            <div style={imgWrapper}>
              <img src={p.imagePath} alt="" style={imgStyle} />
            </div>

            <div style={cardContent}>
              <h4 style={{ marginBottom: 5 }}>{p.name}</h4>
              <p style={descStyle}>{p.description}</p>

              <p style={{ fontWeight: "bold", marginTop: 5 }}>
                ${p.price}
              </p>

              {/* ACTION */}
              <div style={actionRow}>
                <button onClick={() => editProduct(p)} style={editBtn}>
                  <EditIcon />
                </button>

                <button onClick={() => deleteProduct(p.id)} style={deleteBtn}>
                  <DeleteIcon />
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* PAGINATION */}
      <div style={{ marginTop: 25, textAlign: "center" }}>
        {Array.from({ length: totalPages }).map((_, i) => (
          <button
            key={i}
            onClick={() => setCurrentPage(i + 1)}
            style={{
              margin: 5,
              padding: "8px 14px",
              borderRadius: 10,
              border: "none",
              background: currentPage === i + 1
                ? "linear-gradient(135deg,#FF9A9E,#FAD0C4)"
                : "#eee",
              color: currentPage === i + 1 ? "#fff" : "#333",
              cursor: "pointer",
              fontWeight: "bold"
            }}
          >
            {i + 1}
          </button>
        ))}
      </div>
    </div>
  );
}

const cardStyle = {
  background: "#fff",
  padding: 20,
  borderRadius: 16,
  boxShadow: "0 4px 20px rgba(255,154,158,0.2)",
  marginBottom: 30
};

const gridForm = {
  display: "grid",
  gridTemplateColumns: "1fr 1fr",
  gap: 12
};

const inputStyle = {
  padding: 10,
  borderRadius: 12,
  border: "1px solid #f3d1d9",
  outline: "none",
};

const btnStyle = {
  marginTop: 15,
  padding: "10px 20px",
  borderRadius: 12,
  border: "none",
  background: "linear-gradient(135deg,#FF9A9E,#FAD0C4)",
  color: "white",
  cursor: "pointer",
  fontWeight: "bold",
  display: "flex",
  alignItems: "center",
  gap: 6
};

const gridProducts = {
  display: "grid",
  gridTemplateColumns: "repeat(5, 1fr)",
  gap: 15
};

const productCard = {
  background: "#fff",
  borderRadius: 14,
  overflow: "hidden",
  boxShadow: "0 4px 12px rgba(0,0,0,0.08)",
  display: "flex",
  flexDirection: "column"
};

const imgWrapper = {
  width: "100%",
  height: 140
};

const imgStyle = {
  width: "100%",
  height: "100%",
  objectFit: "cover"
};

const cardContent = {
  padding: 12,
  display: "flex",
  flexDirection: "column",
  flex: 1
};

const descStyle = {
  fontSize: 12,
  color: "#666",
  overflow: "hidden",
  display: "-webkit-box",
  WebkitLineClamp: 2,
  WebkitBoxOrient: "vertical"
};

const actionRow = {
  marginTop: "auto",
  display: "flex",
  gap: 10
};

const editBtn = {
  flex: 1,
  height: 36,
  borderRadius: 10,
  border: "none",
  background: "#FFD6E0",
  cursor: "pointer",
  display: "flex",
  alignItems: "center",
  justifyContent: "center"
};

const deleteBtn = {
  flex: 1,
  height: 36,
  borderRadius: 10,
  border: "none",
  background: "#FF8A8A",
  color: "white",
  cursor: "pointer",
  display: "flex",
  alignItems: "center",
  justifyContent: "center"
};