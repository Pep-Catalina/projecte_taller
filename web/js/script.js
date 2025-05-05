// document.getElementById('citaForm').addEventListener('submit', async function (event) {
//     event.preventDefault();

//     // Recollim les dades del formulari
//     const dni = document.getElementById('dni').value.trim();
//     const nomComplet = document.getElementById('nom').value.trim();
//     const telefon = document.getElementById('telefon').value.trim();
//     const email = document.getElementById('email').value.trim();
//     const dataCita = document.getElementById('data_cita').value;
//     const motiuConsulta = document.getElementById('motiu_consulta').value.trim();

//     // Separem el nom i cognom (opcional, segons com tinguis la BBDD)
//     const [nom, ...restCognoms] = nomComplet.split(" ");
//     const cognom = restCognoms.join(" ");

//     try {
//         // Primer, creem el pacient
//         const respostaPacient = await fetch('http://localhost:5000/pacients', {
//             method: 'POST',
//             headers: {
//                 'Content-Type': 'application/json'
//             },
//             body: JSON.stringify({
//                 nom: nom,
//                 cognom: cognom,
//                 telefon: telefon,
//                 correu: email
//             })
//         });

//         const resultatPacient = await respostaPacient.json();

//         if (!respostaPacient.ok) {
//             throw new Error(resultatPacient.error || "No s'ha pogut crear el pacient.");
//         }

//         alert("Pacient creat correctament.");

//         // Un cop el pacient estigui creat, obtenim l'ID del pacient creat
//         const pacientId = resultatPacient.id; // Assegura't que el backend retorni l'ID del pacient creat

//         // Ara, creem la visita (cita)
//         const respostaVisita = await fetch('http://localhost:5000/visites', {
//             method: 'POST',
//             headers: {
//                 'Content-Type': 'application/json'
//             },
//             body: JSON.stringify({
//                 pacient_id: pacientId,
//                 data_visita: dataCita,
//                 motiu_visita: motiuConsulta
//             })
//         });

//         const resultatVisita = await respostaVisita.json();

//         if (respostaVisita.ok) {
//             alert("Cita creada correctament.");
//         } else {
//             throw new Error(resultatVisita.error || "No s'ha pogut crear la cita.");
//         }
        
//     } catch (error) {
//         alert("Error: " + error.message);
//     }
// });

document.getElementById('citaForm').addEventListener('submit', async function (event) {
   
    event.preventDefault();

    
    async function afegirPacient() {
        const dni = document.getElementById('dni').value.trim();
        const nomComplet = document.getElementById('nom').value.trim();
        const telefon = document.getElementById('telefon').value.trim();
        const email = document.getElementById('email').value.trim();
        const dataCita = document.getElementById('data_cita').value;
        const motiuConsulta = document.getElementById('motiu_consulta').value.trim();
    
        const [nom, ...restCognoms] = nomComplet.split(" ");
        const cognom = restCognoms.join(" ");
    
        try {
            const resposta = await fetch('http://localhost:5000/pacients', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    nom,
                    cognom,
                    telefon,
                    correu: email,
                    data_cita: dataCita,
                    motiu_consulta: motiuConsulta
                })
            });
    
            const resultat = await resposta.json();
    
            if (!resposta.ok) {
                alert("Error en crear el pacient i la cita.");
            } else {
                alert("Pacient i cita creats correctament.");
            }
        } catch (error) {
            console.error("Error:", error);
            alert("Error en enviar les dades.");
        }
    }
    
    // Recollim les dades del formulari
    const dni = document.getElementById('dni').value.trim();
    const nomComplet = document.getElementById('nom').value.trim();
    const telefon = document.getElementById('telefon').value.trim();
    const email = document.getElementById('email').value.trim();
    const dataCita = document.getElementById('data_cita').value;
    const motiuConsulta = document.getElementById('motiu_consulta').value.trim();

    // Separem el nom i cognom (opcional, segons com tinguis la BBDD)
    const [nom, ...restCognoms] = nomComplet.split(" ");
    const cognom = restCognoms.join(" ");

    try {
        // Enviem la petició POST per crear el pacient
        const respostaPacient = await fetch('http://localhost:5000/pacients', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                nom: nom,
                cognom: cognom,
                telefon: telefon,
                correu: email,
                data_cita: dataCita,           // Afegir data de la cita
                motiu_consulta: motiuConsulta  // Afegir motiu de la consulta
            })
        });

        const resultat = await respostaPacient.json();

        if (!respostaPacient.ok) {
            alert("Error en crear el pacient i la cita.");
            return;
        }

        alert("Pacient i cita creats correctament.");
    } catch (error) {
        console.error("Error:", error);
        alert("Error al enviar les dades.");
    }
});
