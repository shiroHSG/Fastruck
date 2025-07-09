import React, { useEffect, useState } from 'react';
import { fetchCargoRequests } from '../../../api/cms';
import { useNavigate } from 'react-router-dom';

const CargoRequestList = () => {
  const [departure, setDeparture] = useState('');
  const [arrival, setArrival] = useState('');
  const [grouped, setGrouped] = useState({});
  const navigate = useNavigate();

  // ✅ 서버에서 화물 데이터를 가져오고 그룹화
  const loadData = async (dep = '', arr = '') => {
    try {
      const filtered = await fetchCargoRequests(dep, arr);

      const groupedByStatus = filtered.reduce((acc, cargo) => {
        const status = cargo.status;
        if (!acc[status]) acc[status] = [];
        acc[status].push(cargo);
        return acc;
      }, {});
      setGrouped(groupedByStatus);
    } catch (e) {
      console.error('화물 요청 목록 불러오기 실패:', e);
    }
  };

  // ✅ 최초 전체 조회
  useEffect(() => {
    loadData();
  }, []);

  // ✅ 검색 클릭
  const handleSearch = () => {
    loadData(departure, arrival);
  };

  return (
    <div>
      <h2>Cargo Requests (검색 포함)</h2>

      <div style={{ marginBottom: '20px' }}>
        <input
          placeholder="출발지"
          value={departure}
          onChange={(e) => setDeparture(e.target.value)}
          style={{ marginRight: '10px' }}
        />
        <input
          placeholder="도착지"
          value={arrival}
          onChange={(e) => setArrival(e.target.value)}
          style={{ marginRight: '10px' }}
        />
        <button onClick={handleSearch}>검색</button>
      </div>

      {Object.entries(grouped).length === 0 ? (
        <p>검색 결과가 없습니다.</p>
      ) : (
        Object.entries(grouped).map(([status, list]) => (
          <div key={status}>
            <h3>{status}</h3>
            <table>
              <thead>
                <tr>
                  <th>번호</th>
                  <th>출발지 → 도착지</th>
                  <th>종류</th>
                </tr>
              </thead>
              <tbody>
                {list.map(({ id, departureLocation, arrivalLocation, cargoType }) => (
                  <tr
                    key={id}
                    onClick={() => navigate(`/cms/cargo/CargoRequestDetail/${id}`)}
                    style={{ cursor: 'pointer' }}
                  >
                    <td>{id}</td>
                    <td>{departureLocation} → {arrivalLocation}</td>
                    <td>{cargoType}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ))
      )}
    </div>
  );
};

export default CargoRequestList;
