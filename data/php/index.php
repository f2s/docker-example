<?php

$link = mysql_connect('mysql', 'test', 'test')
        or die ('Could not connect: ' . mysql_error());

echo "<b>App Container hostname:</b> " . gethostname() . "<br>\n";
echo "PHP container reading from a database container attached using docker links<br><br>\n";

mysql_select_db('test') or die('Could not select database');

$query = 'insert into my_table values ( "page_view", now() )';
$result = mysql_query($query) or die ("Query failed: " . mysql_error());
mysql_free_result($result);

$query = 'select * from my_table order by value desc';
$result = mysql_query($query) or die('Query failed: ' . mysql_error());

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
