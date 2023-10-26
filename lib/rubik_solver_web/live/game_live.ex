defmodule RubikSolverWeb.GameLive do
  use RubikSolverWeb, :live_view

  # alias RubikSolver.Game.Cube

  def mount(_params, _session, socket) do
    {:ok, socket}
    # {:ok, assign(socket, :cube, Cube.new())}
  end

  def render(assigns) do
    ~H"""
    <div class="scene" id="scene" phx-hook="Cube">
      <div class="pivot centered" id="pivot" style="transform: rotateX(-35deg) rotateY(-135deg)">
        <div class="cube" id="cube">
          <%= for _ <- 1..26, do: get_html_piece() %>
        </div>
      </div>

    </div>

    <div id="guide">
      <div class="anchor" id="anchor3" style="transform: translateZ(3px) translateY(-33.33%) rotate(-270deg) translateY(66.67%)"></div>
      <div class="anchor" id="anchor2" style="transform: translateZ(3px) translateY(-33.33%) rotate(-180deg) translateY(66.67%)"></div>
      <div class="anchor" id="anchor1" style="transform: translateZ(3px) translateY(-33.33%) rotate(-90deg) translateY(66.67%)"></div>
      <div class="anchor" id="anchor0" style="transform: translateZ(3px) translateY(-33.33%) rotate(0deg) translateY(66.67%)"></div>
    </div>
    """
  end

  # duplicate assembleCube

  defp get_html_piece() do
  # defp get_html_piece(%Cube{faces: faces}, piece_id) do
    # piece =
    #   case piece_id do
    #     1 ->
    #       %{
    #         back: nil,
    #         bottom: nil,
    #         front: faces[:front][0],
    #         left: faces[:left][2],
    #         right: nil,
    #         top: faces[:up][6],
    #       }

    #     _ ->
    #       %{
    #         back: :white,
    #         bottom: :red,
    #         front: :yellow,
    #         left: :blue,
    #         right: :green,
    #         top: :orange,
    #       }
    #   end

    raw(
      """
      <div class="piece">
        <div class="element left"></div>
        <div class="element right"></div>
        <div class="element top"></div>
        <div class="element bottom"></div>
        <div class="element back"></div>
        <div class="element front"></div>
      </div>
      """
    )

    # raw(
    #   """
    #   <div class="piece">
    #     <div class="element left">
    #     </div>
    #     <div class="element right">
    #     </div>
    #     <div class="element top">
    #     </div>
    #     <div class="element bottom">
    #     </div>
    #     <div class="element back">
    #     </div>
    #     <div class="element front">
    #     </div>
    #   </div>
    #   """
    # )
  end
end
