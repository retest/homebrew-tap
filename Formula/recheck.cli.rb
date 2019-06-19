class RecheckCli < Formula
  desc "Command-line interface for recheck"
  homepage "https://retest.de/"
  url "https://github.com/retest/recheck.cli/releases/download/v1.1.0/recheck.cli-1.1.0-bin.zip"
  sha256 "7dbad4fb9f8bc1063b687e5a550b2010e40783ee739feec14633ed145edc271c"

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
