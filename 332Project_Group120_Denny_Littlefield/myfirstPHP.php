<!DOCTYPE html>
<html>
    <link href="style.css" type="text/css" rel="stylesheet" >
    <body>
        <h1>Employee Information</h1>
        <table>
            <tr><th>Animal ID</th>
                <th>Specied</th>
                <th>Arrival Location</th>
                <th>Date Of Arrival</th>
                <th>Date Of Departure</th>
                <th>Current Location</th>
            </tr>
            <?php
                $user = 'root';
                $pass = '';
                $name = 'spcadb';
                $host = 'localhost';
            
            try
                {
                    $db = new PDO("mysql:host=" . $host . ";dbname=" . $name, $user, $pass);
                    
                }
                catch(PDOException $e)
                {
                    $msg = $e->getMessage();
                    echo $msg;
                }
                $givenName = $_POST["firstname"];
                $surname = $_POST["lastname"];
                $rows = $db->query("select * from animals");
                foreach($rows as $row) 
                {
		              echo  "<tr><td>".$row[0].
                            "</td><td>".$row[1].
                            "</td><td>".$row[2].
                            "</td><td>".$row[3].
                            "</td><td>".$row[4].
                            "</td><td>".$row[5].
                            "</tr>";
                }
            ?>
        </table>
    </body>
</html>



