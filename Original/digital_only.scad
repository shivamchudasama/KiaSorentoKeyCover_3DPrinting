// Kia Sorento Key Case - Digital Key Fob Only
// Removes the physical mechanical key slot above the main fob housing.

module digital_fob_case() {
    difference() {
        import("kia_sorento_key_case_raw.stl", convexity=10);
        
        // Remove the mechanical key slot located above the main case top plane (Z = 10.302 mm)
        translate([-10, -10, 10.302])
            cube([70, 100, 20]);
    }
}

digital_fob_case();
