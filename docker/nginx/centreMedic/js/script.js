document.getElementById('citaForm').addEventListener('submit', async function (event) {
    event.preventDefault();

    const dni = document.getElementById('dni').value.trim();
    const nomComplet = document.getElementById('nom').value.trim();
    const telefon = document.getElementById('telefon').value.trim();
    const email = document.getElementById('email').value.trim();
    const dataCita = document.getElementById('data_cita').value;
    const motiuConsulta = document.getElementById('motiu_consulta').value.trim();

    const [nom, ...restCognoms] = nomComplet.split(" ");
    const cognom = restCognoms.join(" ");

    try {
        const resposta = await fetch('http://192.168.1.2:5000/pacients', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                dni,
                nom,
                cognom,
                telefon,
                correu: email,
                data_cita: dataCita,           // Afegir data de la cita
                motiu_consulta: motiuConsulta  // Afegir motiu de la consulta
            })
        });

        const resultat = await resposta.json();

        if (!resposta.ok) {
            alert("Error en crear el pacient i la cita.");
            return;
        }

        alert("Pacient i cita creats correctament.");
    } catch (error) {
        console.error("Error:", error);
        alert("Error al enviar les dades.");
    }
});
