defmodule MbtiBsky.Llm do
  @default_endpoint "https://aihubmix.com/v1/chat/completions"

  def chat_completion(request) do
    Req.post(endpoint_url(),
      json: set_stream(request, false),
      auth: {:bearer, api_key()},
      receive_timeout: 600_000
    )
  end

  defp set_stream(request, value) do
    request
    |> Map.drop([:stream, "stream"])
    |> Map.put(:stream, value)
  end

  defp endpoint_url do
    System.get_env("LLM_ENDPOINT") || @default_endpoint
  end

  defp api_key do
    System.get_env("LLM_API_KEY")
  end

  def parse_chat(%{"choices" => [%{"message" => %{"content" => content}} | _]}) do
    {:ok, content}
  end

  def parse_chat(error) do
    error
  end
end
