import { useEffect, useState } from 'react';
import './Products.css';
import { Link } from 'react-router-dom';

const BASE_URL = 'http://localhost:8000/'; // Warehouse API must be ran at port 8000

export const Products = () => {
    const [products, setProducts] = useState([]);

    useEffect(() => {
        fetch(BASE_URL + 'products')
            .then((response) => {
                const json = response.json();
                if (response.ok) {
                    return json;
                }
                throw response;
            })
            .then((data) => {
                setProducts(data);
            })
            .catch((error) => {
                console.log(error);
            });
    });

    const handleDelete = (event, id) => {
        event?.preventDefault();
        const requestOptions = {
            method: 'DELETE',
        };
        fetch(BASE_URL + 'product/' + id, requestOptions)
            .then((response) => {
                if (response.ok) {
                    window.location.reload();
                }
                throw response;
            })
            .catch((error) => {
                console.log(error);
            });
    };

    return (
        <div className="product_div body">
            <div className="product_title title">Products</div>
            <div className="products_add_div">
                <Link to={`/create`} className="product_add button-4">
                    Add
                </Link>
                <table className="products_table">
                    <thead className="products_table_head">
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Price</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Actions</th>
                    </thead>
                    <tbody>
                        {products.map((product) => {
                            return (
                                <tr
                                    className="products_table_row"
                                    key={product.id}
                                >
                                    <td className="product_table_td">
                                        {product.id}
                                    </td>
                                    <td className="product_table_td">
                                        {product.name}
                                    </td>
                                    <td className="product_table_td">
                                        {product.price}
                                    </td>
                                    <td className="product_table_td">
                                        {product.quantity}
                                    </td>
                                    <td className="product_table_td">
                                        <a
                                            href="#"
                                            className="product_delete_link"
                                            onClick={(event) =>
                                                handleDelete(event, product.id)
                                            }
                                        >
                                            Delete
                                        </a>
                                    </td>
                                </tr>
                            );
                        })}
                    </tbody>
                </table>
            </div>
            <div className="products_order_div">
                <Link to={`/order`} className="products_order button-4">
                    Order
                </Link>
            </div>
        </div>
    );
};
