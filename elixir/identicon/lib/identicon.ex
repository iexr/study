defmodule Identicon do

  @moduledoc """

  Hello!

  Here is a brief explanation of how everything works:
  Basically, the whole thing is just a series of functions
  being executed one after another through the pipe function ("|>").

  First, we get a text input from the user through the 
  "Identicon.main("___")" function. 

  Then, the "hashinput" function is executed, taking the user's
  input and transforming it into a list of numbers. 

  What follows next is the "colorpicker" function, 
  which takes the first three numbers from the hash string 
  and assign those numbers to Red, Green and Blue values,
  respectively, under the "color:" category in our struct
  (called "image.ex").

  Now, here's where things get a bit complicated.
  The idea behind the next few functions is basically
  to create a grid in a specific way so that our image
  is always generated in a symmetrical fashion.

  The "creategrid" function here is, in fact a series 
  of functions being applied in sequence, again, using
  the pipe function.

  First of all, it will take the list of all the numbers 
  from the output of "hashinput" and split them into 
  sub-lists of 3, using the "Enum.chunk(3)" function.

  What follows is the "mirrorrow" function being applied 
  to all those sub-lists through the "Enum.map" function. 
  The "mirrorrow" basically takes the first two elements 
  of each of these sub-lists, change their order and make 
  a new list, re-applying those two elements after the third 
  one, so that the list becomes mirrored.
  It may sound a bit confusing and I apologize, but here's an example:

      The word "Sample" will output the following list of numbers:
      [197, 221, 27, 38, 151, 114, 15, 230, 146, 197, 41, 104, 141, 63, 79, 41]
      Now, after passing through the "Enum.chunk(3)" function,
      the first three numbers will be put into the following
      sub-list: [197, 221, 27]. What the "mirrorrow" function
      will do, then, is take "197" and "221", change their order
      and re-apply them into a new list, which will be [197, 221, 27, 221, 197].
      That's basically it.

  Next, we have the "List.flatten" function, which will, well,
  "flatten" our sub-lists into a new one without sub-lists, where
  the numbers are not being contained by groups of 3 or 5.

  And finally, we assign each number an index in the grid through
  the "Enum.with_index" function.

  From here on out, it's really simple.
  The "filtering" function will basically "filter out"
  the even numbers from the list, so that it appears
  as a white background when the image is drawn.
  


  """


  def main(input) do
    input
    |> hashinput
    |> colorpicker
    |> creategrid
    |> filtering
    |> pixelmapf
    |> drawimage
    |> saveimage(input)
  end

  def saveimage(image, input) do
    File.write("./images/#{input}.png", image)
  end

  def drawimage(%Identicon.Image{color: color, pixelmapv: pixelmapv}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)
    Enum.each pixelmapv, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  def pixelmapf(%Identicon.Image{grid: grid} = image) do
    pixelmapv = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50
      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}
      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixelmapv: pixelmapv}
  end

  def filtering(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end

  def creategrid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirrorrow/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirrorrow(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def colorpicker(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hashinput(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}   
  end


end
