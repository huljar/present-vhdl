package util is
    -- Possible values for key size in PRESENT are 80 bit and
    -- 128 bit. However, when only specifying those 2 options
    -- in key_enum, Vivado (version 2016.4) produces an error
    -- during synthesis:
    --
    -- [Synth 8-690] width mismatch in assignment; target has 1 bits, source has 32 bits
    --
    -- When adding a 3rd value to key_enum (and key_bits), the
    -- synthesis works fine. This is a kind of dirty workaround,
    -- but I have no idea why this error occurs. Apparently,
    -- Vivado treats enums or arrays with 2 entries very
    -- differently from those with 3 (or more) entries.
    --
    -- The latest version of Xilinx ISE was able to synthesize
    -- the project without this workaround.
    type key_enum is (K_80, K_128, K_UNUSED);
    type key_lookup is array(key_enum) of natural;
    constant key_bits: key_lookup := (
        K_80  =>  80,
        K_128 => 128,
        K_UNUSED => 0
    );
end package;
