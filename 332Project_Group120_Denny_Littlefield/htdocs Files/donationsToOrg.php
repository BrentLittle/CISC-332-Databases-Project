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
                $rows = $db->prepare("select * from donations where receiver =\"$orgName\" AND donation_date BETWEEN '2017-12-31' AND '2019-01-01'");
                $rows->execute();
                $no=$rows->rowCount();
                //echo " No of records = ".$no;  
                if ($no > 0)
                {
                    echo "<tr><th>Donator</th><th>Reciever</th><th>Donation Date</th><th>Amount</th></tr>";
                    foreach($rows as $row) 
                    {
		              echo  "<tr><td>".$row[0].
                            "</td><td>".$row[1].
                            "</td><td>".$row[2].
                            "</td><td>".$row[3].
                            "</td></tr>";
                    }
                }
                else
                {
                    echo "<h2>No Donations made to $orgName in 2018</h2>";
                    die();
                }
            ?>
        </table>
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
            $rows = $db->query("select SUM(amount) from donations where receiver =\"$orgName\"");
            echo "<br>";
            echo "<p>Amount donated to $orgName in 2018 was: </P>";          
            foreach($rows as $row) 
            {
                echo  "<p><b>$$row[0]</p><p>";
            }
        ?>
        </div>
    </body>
</html>
