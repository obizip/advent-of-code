import std::io, std::io::file, std::collections::list, std::ascii;

fn long? solve1(List{String} lines)
{
	long ans = 0;
	foreach (line : lines) {
		long i = -1;
		while (true) {
			i++;
			if (i + 4 > line.len - 1) break;
			if (line[i:4] == "mul(") {
				i += 4;

				if (!ascii::is_digit(line[i])) continue;
				DString first = dstring::temp();
				for (;ascii::is_digit(line[i]);i++) first.append_char(line[i]);
				// io::printfn("first: %s", first.str_view());

				if (!(line[i] == ',')) continue;
				i++;

				if (!ascii::is_digit(line[i])) continue;
				DString second = dstring::temp();
				for (;ascii::is_digit(line[i]);i++) second.append_char(line[i]);
				// io::printfn("second: %s", second.str_view());

				if (!(line[i] == ')')) continue;
				ans += first.str_view().to_long()! * second.str_view().to_long()!;
			}
		}
	}
	return ans;
}

fn long? solve2(List{String} lines)
{
	long ans = 0;
	bool is_enabled = true;
	foreach (line : lines) {
		long i = -1;
		while (true) {
			i++;
			if (i + 4 > line.len - 1) break;

			if (line[i:4] == "do()") {
				is_enabled = true;
			}

			if ((i + 7 < line.len - 1) && (line[i:7] == "don't()")) {
				is_enabled = false;
			}

			if (is_enabled && line[i:4] == "mul(") {
				i += 4;

				if (!ascii::is_digit(line[i])) continue;
				DString first = dstring::temp();
				for (;ascii::is_digit(line[i]);i++) first.append_char(line[i]);
				// io::printfn("first: %s", first.str_view());

				if (!(line[i] == ',')) continue;
				i++;

				if (!ascii::is_digit(line[i])) continue;
				DString second = dstring::temp();
				for (;ascii::is_digit(line[i]);i++) second.append_char(line[i]);
				// io::printfn("second: %s", second.str_view());

				if (!(line[i] == ')')) continue;
				ans += first.str_view().to_long()! * second.str_view().to_long()!;
			}
		}
	}
	return ans;
}

fn void main()
{
	@pool()
	{
		// File f = file::open("input/input03-test.txt", "rb")!!;
		File f = file::open("input/input03.txt", "rb")!!;
		defer (void)f.close();

		List{String} lines;
		while (try line = io::treadline(&f)) lines.push(line);

		io::printfn("Q1: %d", solve1(lines)!!);
		io::printfn("Q2: %d", solve2(lines)!!);
	};
}
