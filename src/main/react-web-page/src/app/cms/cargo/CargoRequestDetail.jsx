// src/app/dashBoardLayout/utilities/cargo/CargoRequestDetail.jsx

import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { fetchCargoRequestById, fetchBidProposalsByCargo } from '../../../api/cms';

const CargoRequestDetail = () => {
  const { id } = useParams();
  const [cargo, setCargo] = useState(null);
  const [bids, setBids] = useState([]);

  useEffect(() => {
    const loadData = async () => {
      try {
        const [cargoData, bidData] = await Promise.all([
          fetchCargoRequestById(id),
          fetchBidProposalsByCargo(id),
        ]);
        setCargo(cargoData);
        setBids(bidData);
      } catch (error) {
        console.error('Detail fetch error:', error);
      }
    };
    loadData();
  }, [id]);

  if (!cargo) return <p>Loading...</p>;

  return (
    <div>
      <h2>Cargo #{cargo.id} - {cargo.cargoType}</h2>
      <p>{cargo.departureLocation} → {cargo.arrivalLocation}</p>
      <p>Status: {cargo.status}</p>

      <h3>입찰 제안 목록</h3>
      <ul>
        {bids.map(({ id, proposedPrice, carrier, status }) => (
          <li key={id}>
            제안자 #{carrier?.id} | 가격: {proposedPrice} | 상태: {status}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default CargoRequestDetail;
