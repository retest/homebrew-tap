class RecheckCli < Formula
  desc "Command-line interface for recheck"
  homepage "https://retest.de/"
  url "https://github.com/retest/recheck.cli/releases/download/v1.4.0/recheck.cli-1.4.0-bin.zip"
  sha256 "e40fd3f4aceecd3d48ddc21b3e9f921d80bce1869071693fc9b02167bb63bded"

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    # Install required content.
    libexec.install "lib/"
    # Create simplified launch script.
    (bin/"recheck").write <<~EOS
      #!/usr/bin/env bash
      exec java -jar #{libexec}/lib/recheck.cli.jar "$@"
    EOS
  end

  def caveats
    <<~EOS
      You can obtain an auto-completion script for Bash and ZSH via the completion command.
      Simply add the resulting output to your .bash_profile and/or .bashrc, for example:
        $ echo "source <(recheck completion)" >> ~/.bash_profile
      Please note that this requires Bash version 4+ (macOS currently comes with version 3).
    EOS
  end

  test do
    out = shell_output("#{bin}/recheck")
    assert_match "recheck [--help] [--version] [COMMAND]", out
  end
end
