<!DOCTYPE html>
<html>
    <link href="format.css" type="text/css" rel="stylesheet" >
    <body>
        <div class="center">
        <button class="header-null-button" type="button" onClick="location.href = 'index.html';">

            SPCA Database
        </button>
        <p>Welcome to the SPCA database.</p>
        <p>Select a Rescue Organization you would like to view drivers for:<p>
                                                                     
        <table>
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
                $rows = $db->query("select name from rescueorganization");
            
                echo '<table class="center">';
            
                foreach($rows as $row)
                {
                    $name = $row[0];
                    //echo $name;
                    //echo "<br>";
                    
                    echo "<tr><td>";
                    
                    echo "<form action=\"driversOfRescueOrg.php\" method=\"get\">";
                    //<form action="donationsToOrg.php" method="post">
                        
                        echo " <input type=\"submit\" name='org' value=\"$name\" />";
                        //<input type="submit" name="orgname" value=$name />
                    
                    echo "</form>";
                    //</form>
                    
                    
                    echo "</td></tr>";
                }
            
                echo '</table>';
            ?>
        </table>
        </div>
    </body>
</html>