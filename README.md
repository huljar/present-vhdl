# PRESENT block cipher - VHDL implementation

This is an implementation of the PRESENT lightweight block cipher
as described in [this paper](https://link.springer.com/chapter/10.1007/978-3-540-74735-2_31).
It encrypts individual blocks of 64 bit length with an 80 or 128 bit key.
The desired key length can be set via the generic `k` (either
`K_80` or `K_128`).

## License
The code is licensed under the terms of the MIT license. For more
information, please see the [LICENSE.md](LICENSE.md) file.
