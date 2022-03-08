defmodule RubikSolver.Game.Cube do
  @moduledoc """
  A module that represents a Rubik's cube and
  functions to manipulate its faces.

  A helpful resource for this module is the
  `docs/flat-cube.jpg` file. The single letters
  correspond to face atoms in this module.

  Moves are rotations of a face. All moves are
  90 degree clockwise rotations of the face
  corresponding to the flattened cube. Prime moves are
  90 degree counter-clockwise rotations.
  """

  defstruct [:faces]

  @colors [
    :blue,
    :green,
    :orange,
    :red,
    :white,
    :yellow
  ]

  @moves [
    :back,
    :back_prime,
    :down,
    :down_prime,
    :front,
    :front_prime,
    :left,
    :left_prime,
    :right,
    :right_prime,
    :up,
    :up_prime
  ]

  @back_face :back
  @down_face :down
  @front_face :front
  @left_face :left
  @right_face :right
  @up_face :up

  @faces [
    @back_face,
    @down_face,
    @front_face,
    @left_face,
    @right_face,
    @up_face
  ]

  def new do
    faces =
      @faces
      |> Enum.zip(@colors)
      |> Enum.map(fn {face, color} ->
        side = 0..8 |> Enum.map(&{&1, color}) |> Map.new()

        {face, side}
      end)
      |> Map.new()

    %__MODULE__{faces: faces}
  end

  def perform_move(%__MODULE__{} = cube, move) when move in @moves do
    swaps =
      case move do
        :back ->
          [
            {@down_face, 6, @right_face, 8},
            {@down_face, 7, @right_face, 5},
            {@down_face, 8, @right_face, 2},
            {@left_face, 0, @down_face, 6},
            {@left_face, 3, @down_face, 7},
            {@left_face, 6, @down_face, 8},
            {@right_face, 2, @up_face, 0},
            {@right_face, 5, @up_face, 1},
            {@right_face, 8, @up_face, 2},
            {@up_face, 0, @left_face, 6},
            {@up_face, 1, @left_face, 3},
            {@up_face, 2, @left_face, 0}
          ]

        :back_prime ->
          [
            {@down_face, 6, @left_face, 0},
            {@down_face, 7, @left_face, 3},
            {@down_face, 8, @left_face, 6},
            {@left_face, 0, @up_face, 2},
            {@left_face, 3, @up_face, 1},
            {@left_face, 6, @up_face, 0},
            {@right_face, 2, @down_face, 8},
            {@right_face, 5, @down_face, 7},
            {@right_face, 8, @down_face, 6},
            {@up_face, 0, @right_face, 2},
            {@up_face, 1, @right_face, 5},
            {@up_face, 2, @right_face, 8}
          ]

        :down ->
          [
            {@back_face, 6, @left_face, 6},
            {@back_face, 7, @left_face, 7},
            {@back_face, 8, @left_face, 8},
            {@front_face, 6, @right_face, 6},
            {@front_face, 7, @right_face, 7},
            {@front_face, 8, @right_face, 8},
            {@left_face, 6, @front_face, 6},
            {@left_face, 7, @front_face, 7},
            {@left_face, 8, @front_face, 8},
            {@right_face, 6, @back_face, 6},
            {@right_face, 7, @back_face, 7},
            {@right_face, 8, @back_face, 8}
          ]

        :down_prime ->
          [
            {@back_face, 6, @right_face, 6},
            {@back_face, 7, @right_face, 7},
            {@back_face, 8, @right_face, 8},
            {@front_face, 6, @left_face, 6},
            {@front_face, 7, @left_face, 7},
            {@front_face, 8, @left_face, 8},
            {@left_face, 6, @back_face, 6},
            {@left_face, 7, @back_face, 7},
            {@left_face, 8, @back_face, 8},
            {@right_face, 6, @front_face, 6},
            {@right_face, 7, @front_face, 7},
            {@right_face, 8, @front_face, 8}
          ]

        :front ->
          [
            {@down_face, 0, @left_face, 2},
            {@down_face, 1, @left_face, 5},
            {@down_face, 2, @left_face, 8},
            {@left_face, 2, @up_face, 8},
            {@left_face, 5, @up_face, 7},
            {@left_face, 8, @up_face, 6},
            {@right_face, 0, @down_face, 2},
            {@right_face, 3, @down_face, 1},
            {@right_face, 6, @down_face, 0},
            {@up_face, 6, @right_face, 0},
            {@up_face, 7, @right_face, 3},
            {@up_face, 8, @right_face, 6}
          ]

        :front_prime ->
          [
            {@down_face, 0, @right_face, 6},
            {@down_face, 1, @right_face, 3},
            {@down_face, 2, @right_face, 0},
            {@left_face, 2, @down_face, 0},
            {@left_face, 5, @down_face, 1},
            {@left_face, 8, @down_face, 2},
            {@right_face, 0, @up_face, 6},
            {@right_face, 3, @up_face, 7},
            {@right_face, 6, @up_face, 8},
            {@up_face, 6, @left_face, 8},
            {@up_face, 7, @left_face, 5},
            {@up_face, 8, @left_face, 2}
          ]

        :left ->
          [
            {@back_face, 2, @up_face, 6},
            {@back_face, 5, @up_face, 3},
            {@back_face, 8, @up_face, 0},
            {@down_face, 0, @back_face, 8},
            {@down_face, 3, @back_face, 5},
            {@down_face, 6, @back_face, 2},
            {@front_face, 0, @down_face, 0},
            {@front_face, 3, @down_face, 3},
            {@front_face, 6, @down_face, 6},
            {@up_face, 0, @front_face, 0},
            {@up_face, 3, @front_face, 3},
            {@up_face, 6, @front_face, 6}
          ]

        :left_prime ->
          [
            {@back_face, 2, @down_face, 6},
            {@back_face, 5, @down_face, 3},
            {@back_face, 8, @down_face, 0},
            {@down_face, 0, @front_face, 0},
            {@down_face, 3, @front_face, 3},
            {@down_face, 6, @front_face, 6},
            {@front_face, 0, @up_face, 0},
            {@front_face, 3, @up_face, 3},
            {@front_face, 6, @up_face, 6},
            {@up_face, 0, @back_face, 8},
            {@up_face, 3, @back_face, 5},
            {@up_face, 6, @back_face, 2}
          ]

        :right ->
          [
            {@back_face, 0, @down_face, 8},
            {@back_face, 3, @down_face, 5},
            {@back_face, 6, @down_face, 2},
            {@down_face, 2, @front_face, 2},
            {@down_face, 5, @front_face, 5},
            {@down_face, 8, @front_face, 8},
            {@front_face, 2, @up_face, 2},
            {@front_face, 5, @up_face, 5},
            {@front_face, 8, @up_face, 8},
            {@up_face, 2, @back_face, 6},
            {@up_face, 5, @back_face, 3},
            {@up_face, 8, @back_face, 0}
          ]

        :right_prime ->
          [
            {@back_face, 0, @up_face, 8},
            {@back_face, 3, @up_face, 5},
            {@back_face, 6, @up_face, 2},
            {@down_face, 2, @back_face, 6},
            {@down_face, 5, @back_face, 3},
            {@down_face, 8, @back_face, 0},
            {@front_face, 2, @down_face, 2},
            {@front_face, 5, @down_face, 5},
            {@front_face, 8, @down_face, 8},
            {@up_face, 2, @front_face, 2},
            {@up_face, 5, @front_face, 5},
            {@up_face, 8, @front_face, 8}
          ]

        :up ->
          [
            {@back_face, 0, @right_face, 0},
            {@back_face, 1, @right_face, 1},
            {@back_face, 2, @right_face, 2},
            {@front_face, 0, @left_face, 0},
            {@front_face, 1, @left_face, 1},
            {@front_face, 2, @left_face, 2},
            {@left_face, 0, @back_face, 0},
            {@left_face, 1, @back_face, 1},
            {@left_face, 2, @back_face, 2},
            {@right_face, 0, @front_face, 0},
            {@right_face, 1, @front_face, 1},
            {@right_face, 2, @front_face, 2}
          ]

        :up_prime ->
          [
            {@back_face, 0, @left_face, 0},
            {@back_face, 1, @left_face, 1},
            {@back_face, 2, @left_face, 2},
            {@front_face, 0, @right_face, 0},
            {@front_face, 1, @right_face, 1},
            {@front_face, 2, @right_face, 2},
            {@left_face, 0, @front_face, 0},
            {@left_face, 1, @front_face, 1},
            {@left_face, 2, @front_face, 2},
            {@right_face, 0, @back_face, 0},
            {@right_face, 1, @back_face, 1},
            {@right_face, 2, @back_face, 2}
          ]
      end

    new_faces =
      Enum.reduce(swaps, cube.faces, fn swap, new_faces ->
        {old_face, old_pos, new_face, new_pos} = swap

        put_in(new_faces, [new_face, new_pos], cube.faces[old_face][old_pos])
      end)

    {:ok, %{cube | faces: new_faces}}
  end

  def perform_move(_cube, _move) do
    {:error, :invalid_move}
  end

  def shuffle(%__MODULE__{} = cube, moves \\ 100) do
    Enum.reduce(1..moves, {:ok, cube}, fn
      _, {:ok, new_cube} ->
        move = Enum.random(@moves)
        perform_move(new_cube, move)

      _, error ->
        error
    end)
  end

  def stringify(%__MODULE__{} = cube) do
    [u1, u2, u3] = stringify_face(cube.faces[@up_face])
    [l1, l2, l3] = stringify_face(cube.faces[@left_face])
    [f1, f2, f3] = stringify_face(cube.faces[@front_face])
    [r1, r2, r3] = stringify_face(cube.faces[@right_face])
    [b1, b2, b3] = stringify_face(cube.faces[@back_face])
    [d1, d2, d3] = stringify_face(cube.faces[@down_face])

    """
        #{u1}
        #{u2}
        #{u3}
    #{l1} #{f1} #{r1} #{b1}
    #{l2} #{f2} #{r2} #{b2}
    #{l3} #{f3} #{r3} #{b3}
        #{d1}
        #{d2}
        #{d3}
    """
  end

  defp stringify_color(color) do
    case color do
      :blue -> "B"
      :green -> "G"
      :orange -> "O"
      :red -> "R"
      :white -> "W"
      :yellow -> "Y"
    end
  end

  defp stringify_face(face) do
    0..8
    |> Enum.map(&stringify_color(face[&1]))
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.join/1)
  end
end
