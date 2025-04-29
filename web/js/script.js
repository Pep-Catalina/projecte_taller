document.getElementById('citaForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Evita que s'envii i recarregui la pàgina

    const cita = {
        dni: document.getElementById('dni').value,
        nom: document.getElementById('nom').value,
        data_cita: document.getElementById('data_cita').value,
        motiu_consulta: document.getElementById('motiu_consulta').value
    };

    fetch('http://localhost:5000/appointments', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(cita)
    })
    .then(response => response.json())
    .then(data => {
        alert('Cita creada correctament!');
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Hi ha hagut un problema en crear la cita.');
    });
});
