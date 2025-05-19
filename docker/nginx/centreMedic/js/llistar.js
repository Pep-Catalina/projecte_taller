document.addEventListener("DOMContentLoaded", function() {
    // Funció per carregar pacients
    async function carregarPacients() {
        try {
            // Fer la petició per obtenir les dades dels pacients
            const resposta = await fetch('http://192.168.1.2:5000/pacients');
            const dades = await resposta.json();

            // Comprovar si les dades han arribat correctament
            console.log(dades);

            // Buscar la taula on es mostraran les dades
            const taula = document.getElementById("taulaPacients");
            if (!taula) {
                console.error("No s'ha trobat la taula 'taulaPacients'.");
                return;
            }

            // Esborrar el contingut existent de la taula
            taula.querySelector("tbody").innerHTML = ""; // Esborrem les files antigues

            // Afegir les noves files amb les dades
            dades.forEach(pacient => {
                const fila = document.createElement("tr");

                const dni = document.createElement("td");
                dni.textContent = pacient.dni;
                fila.appendChild(dni);

                const nom = document.createElement("td");
                nom.textContent = pacient.nom + " " + pacient.cognom;
                fila.appendChild(nom);

                const dataVisita = document.createElement("td");
// Si la data de visita és null o buida, mostrar "No disponible"
if (pacient.data_visita) {
    const data = new Date(pacient.data_visita);
    // Convertim la data en el format compactat: YYYY-MM-DD
    const dataFormatejada = data.toISOString().split('T')[0];
    dataVisita.textContent = dataFormatejada;
} else {
    dataVisita.textContent = "No disponible";
}
fila.appendChild(dataVisita);


                const motiuVisita = document.createElement("td");
                // Si el motiu de la visita és null o buid, mostrar "No disponible"
                motiuVisita.textContent = pacient.motiu_visita ? pacient.motiu_visita : "No disponible";
                fila.appendChild(motiuVisita);

                // Afegir la fila a la taula
                taula.querySelector("tbody").appendChild(fila);
            });
        } catch (error) {
            console.error("Error carregant pacients:", error);
        }
    }

    // Cridar la funció per carregar les dades quan la pàgina carregui
    carregarPacients();
});
