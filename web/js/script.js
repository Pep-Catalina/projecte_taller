
document.getElementById('citaForm').addEventListener('submit', async function(e) {
    e.preventDefault();
    const vehicle_id = document.getElementById('vehicle_id').value;
    const data_cita = document.getElementById('data_cita').value;
    const servei_sollicitat = document.getElementById('servei_sollicitat').value;

    const response = await fetch('http://localhost:5000/appointments', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ vehicle_id, data_cita, servei_sollicitat })
    });

    const result = await response.json();
    alert(result.message);
});
