defmodule Newsletter do
  def read_emails(path) do
    # read by line
    File.read!(path)
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    # Please implement the log_sent_email/2 function
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)

    read_emails(emails_path)
    |> Enum.each(fn email ->
      case send_fun.(email) do
        :ok -> log_sent_email(pid, email)
        _ -> :ok
      end
    end)

    close_log(pid)
  end
end
