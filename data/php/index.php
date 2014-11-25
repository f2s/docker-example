<?php


$link = mysql_connect('mysql', 'test', 'test')
        or die ('Could not connect: ' . mysql_error());
mysql_select_db('test')
        or die('Could not select database');

echo "<b>App Container hostname:</b> " . gethostname() . "<br>\n";
$query = 'select @@hostname';
$result = mysql_query($query) 
          or die ("Query failed: " . mysql_error());
echo "<b>DB Container hostname:</b> " . implode(',',mysql_fetch_assoc($result)) . "<br>\n";
mysql_free_result($result);
echo "Nginx (reverse proxy) directing to Apache PHP (application) container reading from a mysql (database) container attached using docker links<br><br>\n";

$query = 'insert into my_table values ( "page_view", now() )';
$result = mysql_query($query) 
          or die ("Query failed: " . mysql_error());
mysql_free_result($result);

$query = 'select * from my_table order by value desc';
$result = mysql_query($query)
          or die('Query failed: ' . mysql_error());

echo "<table>\n";
while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
	echo "\t<tr>\n";
	foreach ($line as $col_value){
		echo "\t\t<td>$col_value</td>\n";
	}
	echo "\t</tr>\n";
}
echo "</table>\n";

mysql_free_result($result);
mysql_close($link);

?>
