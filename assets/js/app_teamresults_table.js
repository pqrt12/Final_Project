// Team results data table
function bodyload(){
    var tbody = d3.select("tbody");

    tbody.html("");
    //console.log(window.location.href);
    var host_site = 'http://' + window.location.host + '/get_tables'
    
    console.log("entering bodyload");
    d3.json(host_site).then(function(team_results){
        console.log(team_results)
        team_results.forEach((dataRow) => {
            let row = tbody.append("tr")
            Object.values(dataRow).forEach((val) => {
                let cell = row.append("td");
                cell.text(val);
            });
        });
    });
}