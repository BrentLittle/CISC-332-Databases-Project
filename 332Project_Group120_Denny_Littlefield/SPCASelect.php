<!DOCTYPE html>
<html>
    <link href="format.css" type="text/css" rel="stylesheet" >
    <body>
        <div class="center">
        <button class="header-null-button" type="button" onClick="location.href = 'index.html';">

            SPCA Database
        </button>
        <p>Welcome to the SPCA database.</p>
        <p>Select an SPCA branch you would like to view the animals from:<p>
                                                                     
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
                $rows = $db->prepare("select name from spcabranch");
                $rows->execute();
            
                echo '<table class="center">';
            
                foreach($rows as $row)
                {
                    $name = $row[0];
                    //echo $name;
                    //echo "<br>";
                    
                    echo "<tr><td>";
                    
                    echo "<form action=\"animalsAtBranch.php\" method=\"get\">";
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