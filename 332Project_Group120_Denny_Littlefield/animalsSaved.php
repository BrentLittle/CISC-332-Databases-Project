<!DOCTYPE html>
<html>
    <link href="formatTables.css" type="text/css" rel="stylesheet" >
    <body>
        <div class="center">
        <button class="header-null-button" type="button" onClick="location.href = 'index.html';">

            SPCA Database
        </button>
        <p>Welcome to the SPCA database.</p>
        <table align="center">
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
                $orgName = $_GET['org'];
                echo "<h2><b>$orgName</b></h2>";
                $rows = $db->prepare("Select animals.animal_id, animals.species, animals.arrival_loc, animals.doa, animals.dod, animals.location FROM animals INNER JOIN rescues ON animals.animal_id=rescues.animal_id WHERE rescues.rescue_name = \"$orgName\" AND animals.dod BETWEEN '2017-12-31' AND '2030-01-01'");
                $rows->execute();
                $no=$rows->rowCount();
                //echo " No of records = ".$no;  
                if ($no > 0)
                {
                    echo "<tr><th>Animal ID</th><th>Species</th><th>Arrival Location</th><th>Date of Arrival</th><th>Date of Departure</th><th>Current Location</th></tr>";
                    foreach($rows as $row) 
                    {
		              echo  "<tr><td>".$row[0].
                            "</td><td>".$row[1].
                            "</td><td>".$row[2].
                            "</td><td>".$row[3].
                            "</td><td>".$row[4].
                            "</td><td>".$row[5].
                            "</td></tr>";
                    }
                }
                else
                {
                    echo "<h2>$orgName saved no animals during 2018</h2>";
                    die();
                }
            ?>
        </table>
        </div>
    </body>
</html>