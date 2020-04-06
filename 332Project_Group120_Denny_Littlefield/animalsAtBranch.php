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
                $rows = $db->prepare("select * from animals where location =\"$orgName\" and dod IS NULL");
                $rows->execute();
                $no=$rows->rowCount();
                //echo " No of records = ".$no;  
                if ($no > 0)
                {
                    echo "<tr><th>Animal ID</th><th>Species</th><th>Arrival Location</th><th>Date of Arrival</th><th>Current Location</th></tr>";
                    foreach($rows as $row) 
                    {
		              echo  "<tr><td>".$row[0].
                            "</td><td>".$row[1].
                            "</td><td>".$row[2].
                            "</td><td>".$row[3].
                            "</td><td>".$row[5].
                            "</td></tr>";
                    }
                }
                else
                {
                    echo "<h2>$orgName has no Animals at their branch</h2>";
                    die();
                }
            ?>
        </table>
        </div>
    </body>
</html>