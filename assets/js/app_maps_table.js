// Map data table
const td = d3.selectAll('#mapnames');
const data = td;
const tableData = data;

// Reference the HTML table using d3
var tbody = d3.select("tbody");

function buildTable(data) {
    //Debugger
    console.log("Im Here")

    // First, clear out any existing data
    tbody.html("");

    // var data = connect();

    // Next, loop through each object in the data
    // and append a row and cells for each value in the row    
    data.each(function() {       

        // Append a row to the table body
        let row = tbody.append("tr");
        let cell = row.append("td");
        cell.text(this.innerText);
        console.log(this);

        // // Loop through each field in the dataRow and add
        // // each value as a table cell (td)
        // Object.values().forEach((val) => {
        //     let cell = row.append("td");
        //     cell.text(val);
        // });
    });
}
buildTable(tableData);