defmodule RubikSolver.Game.CubeTest do
  use ExUnit.Case

  alias RubikSolver.Game.Cube

  @fixed_cube %Cube{
    faces: %{
      back: %{
        0 => :blue,
        1 => :blue,
        2 => :blue,
        3 => :blue,
        4 => :blue,
        5 => :blue,
        6 => :blue,
        7 => :blue,
        8 => :blue
      },
      down: %{
        0 => :green,
        1 => :green,
        2 => :green,
        3 => :green,
        4 => :green,
        5 => :green,
        6 => :green,
        7 => :green,
        8 => :green
      },
      front: %{
        0 => :orange,
        1 => :orange,
        2 => :orange,
        3 => :orange,
        4 => :orange,
        5 => :orange,
        6 => :orange,
        7 => :orange,
        8 => :orange
      },
      left: %{
        0 => :red,
        1 => :red,
        2 => :red,
        3 => :red,
        4 => :red,
        5 => :red,
        6 => :red,
        7 => :red,
        8 => :red
      },
      right: %{
        0 => :white,
        1 => :white,
        2 => :white,
        3 => :white,
        4 => :white,
        5 => :white,
        6 => :white,
        7 => :white,
        8 => :white
      },
      up: %{
        0 => :yellow,
        1 => :yellow,
        2 => :yellow,
        3 => :yellow,
        4 => :yellow,
        5 => :yellow,
        6 => :yellow,
        7 => :yellow,
        8 => :yellow
      }
    }
  }

  describe "new/0" do
    test "generates a Cube struct" do
      assert %Cube{} = Cube.new()
    end
  end

  describe "perform_move/2" do
    test "each legal move mutates the cube's faces as expected" do
      cube = @fixed_cube

      assert Cube.stringify(cube) ==
               """
                   YYY
                   YYY
                   YYY
               RRR OOO WWW BBB
               RRR OOO WWW BBB
               RRR OOO WWW BBB
                   GGG
                   GGG
                   GGG
               """

      {:ok, cube} = Cube.perform_move(cube, :back)

      assert Cube.stringify(cube) ==
               """
                   WWW
                   YYY
                   YYY
               YRR OOO WWG BBB
               YRR OOO WWG BBB
               YRR OOO WWG BBB
                   GGG
                   GGG
                   RRR
               """

      {:ok, cube} = Cube.perform_move(cube, :down)

      assert Cube.stringify(cube) ==
               """
                   WWW
                   YYY
                   YYY
               YRR OOO WWG BBB
               YRR OOO WWG BBB
               BBB YRR OOO WWG
                   GGG
                   GGG
                   RRR
               """

      {:ok, cube} = Cube.perform_move(cube, :front)

      assert Cube.stringify(cube) ==
               """
                   WWW
                   YYY
                   BRR
               YRG OOO YWG BBB
               YRG OOO YWG BBB
               BBG YRR YOO WWG
                   OWW
                   GGG
                   RRR
               """

      {:ok, cube} = Cube.perform_move(cube, :left)

      assert Cube.stringify(cube) ==
               """
                   GWW
                   BYY
                   BRR
               YRG WOO YWG BBR
               YRG YOO YWG BBG
               BBG BRR YOO WWO
                   OWW
                   OGG
                   YRR
               """

      {:ok, cube} = Cube.perform_move(cube, :right)

      assert Cube.stringify(cube) ==
               """
                   GWO
                   BYO
                   BRR
               YRG WOW YWG RBR
               YRG YOG YWG YBG
               BBG BRR YOO WWO
                   OWW
                   OGB
                   YRB
               """

      {:ok, cube} = Cube.perform_move(cube, :up)

      assert Cube.stringify(cube) ==
               """
                   GWO
                   BYO
                   BRR
               WOW YWG RBR YRG
               YRG YOG YWG YBG
               BBG BRR YOO WWO
                   OWW
                   OGB
                   YRB
               """

      # performing the reverse moves should get us back the original cube
      {:ok, cube} = Cube.perform_move(cube, :up_prime)
      {:ok, cube} = Cube.perform_move(cube, :right_prime)
      {:ok, cube} = Cube.perform_move(cube, :left_prime)
      {:ok, cube} = Cube.perform_move(cube, :front_prime)
      {:ok, cube} = Cube.perform_move(cube, :down_prime)
      {:ok, cube} = Cube.perform_move(cube, :back_prime)

      assert Cube.stringify(cube) ==
               """
                   YYY
                   YYY
                   YYY
               RRR OOO WWW BBB
               RRR OOO WWW BBB
               RRR OOO WWW BBB
                   GGG
                   GGG
                   GGG
               """
    end

    test "illegal move" do
      assert Cube.perform_move(@fixed_cube, :nope) == {:error, :invalid_move}
    end
  end

  describe "shuffle/1" do
    test "it mixes up the cube's faces" do
      assert Cube.shuffle(@fixed_cube) != @fixed_cube
    end
  end

  describe "stringify/1" do
    test "it generates a string representation of the cube's faces" do
      assert Cube.stringify(@fixed_cube) ==
               """
                   YYY
                   YYY
                   YYY
               RRR OOO WWW BBB
               RRR OOO WWW BBB
               RRR OOO WWW BBB
                   GGG
                   GGG
                   GGG
               """
    end
  end
end
