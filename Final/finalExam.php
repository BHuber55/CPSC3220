<!DOCTYPE php>
<!--	Author:    Brennan Huber
      Date:    December 12, 2017
      File:    finalExam.php
      Purpose:  Final..
-->
<html>
<head>
	<title>Final Exam</title>
</head>
<body>
	<form action="movies.html">
   	<input type="submit" value="Movies Page" />
	</form>

	<?php
      $connect = mysqli_connect('localhost', 'root', '', 'sakila');

      if(!$connect)
      {
         print("<p>RIP</p>");
         return;
      }

      $query =
        "SELECT title, actor.last_name, actor.first_name
         FROM film
         LEFT JOIN film_actor ON film.film_id = film_actor.film_id
         RIGHT JOIN actor ON film_actor.actor_id = actor.actor_id
         ORDER BY film.title;";

      $result = mysqli_query($connect, $query);

      // this is going to be used to see if the title of the film has changed..
      $prev = "";
      // this is going to be used to append the line that we will write to the file..
      $line = "" ;
      // used to count the number of movies..
      $count = 1;

      $row = mysqli_fetch_array($result);
      $prev = $row[0];
      $line = "$row[0]" . ":" . $row[2] . ", " . $row[1] . ";" ;

      $file = fopen("FilmActors.txt", "w+");

      while($row = mysqli_fetch_array($result))
      {
         if(strcmp($row[0], $prev) != 0)
         {
            // NEED TO COUNT THE NUMBER OF ACTORS IN THESE MOVIES..
            $arr = explode(":", $line);
            $line = $arr[0] . ":" . $count . ":" . $arr[1];

            // so it changed titles.. so we write that one line because its done.
            // WRITE TO TEXT FILE
            fwrite($file, $line . "\n");

            // now we set line to the start of the new movie..
            $line = "$row[0]:";
            $prev = $row[0];
            $count = 1;
         }

         // increment count because we have a movie
         $count++;

         // now we append the appropriate information to line.
         $line = $line . $row[2] . ", " . $row[1] . ";";
      }

      mysqli_close($connect);



      // Task 2
      $file = fopen("input.csv", "r");
      $data = array();

      while(($line = fgets($file)) != false)
      {
         $arr = explode(",", $line);
         $data[$arr[0]] = $arr;
      }

      print("<table border=\"1\">");
      print("<th>Last Name</th>");
      print("<th>First Name</th>");
      print("<th>Address</th>");
      print("<th>City</th>");
      print("<th>District</th>");
      print("<th>Postal</th>");

      foreach($data as $d)
      {
         print("<tr>");
         for($i = 0; $i < 6; $i++)
         {
            print("<td>$d[$i]</td>");
         }
         print("</tr>");
      }

      print("</table>");

	?>

</body>
</html>
