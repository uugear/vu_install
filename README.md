# vu_install
A collection of scripts that install something useful into Vivid Unit.

These scripts can help you to install things that require more than just "sudo apt install".

---

### Enable GPU (Mali T860):
Run this command to fully unlock the GPU acceleration on your Vivid Unit:

`$ curl -sL https://github.com/uugear/vu_install/raw/main/enable_gpu.sh | bash`

or use this shorter version:

`curl -sL https://bit.ly/ENGPU | bash`

![Enable GPU](pictures/ENGPU-glmark2-es2.jpg?raw=true "Fully Unlock GPU on Vivid Unit")

After this upgrade, your Vivid Unit's glmark2-es2 score will be about 300 (was about 55 before this upgrade).
The score can go even higher (about 500) if you test it with external display that has higher refresh rate.

---

### Spotify (digital music streaming):
Run this command to install [Spotify](https://open.spotify.com/) app into your Vivid Unit:

`$ curl -sL https://github.com/uugear/vu_install/raw/main/spotify.sh | bash`

or use this shorter version:

`curl -sL https://bit.ly/888AA | bash`

![Spotify](pictures/Spotify.jpg?raw=true "Run Spotify on Vivid Unit")

---

### Gqrx (software defined radio receiver = SDR)
Run this command to install [Gqrx](https://www.gqrx.dk/) into your Vivid Unit:

`$ curl -sL https://github.com/uugear/vu_install/raw/main/gqrx.sh | bash`

or use this shorter version:

`curl -sL https://bit.ly/GQRX5 | bash`

![Gqrx](pictures/Gqrx.jpg?raw=true "Run Gqrx on Vivid Unit")

The GNU Radio Companion is also installed by this script.

![GNU Radio Companion](pictures/GNU_Radio_Companion.jpg?raw=true "Run GNU Radio Companion on Vivid Unit")
