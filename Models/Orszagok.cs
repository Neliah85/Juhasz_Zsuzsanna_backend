using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace Juhász_Zsuzsanna_backend.Models;

public partial class Orszagok
{
    public int Id { get; set; }

    public string Nev { get; set; } = null!;

    public string Nobid { get; set; } = null!;
    [JsonIgnore]
    public virtual ICollection<Versenyzok> Versenyzoks { get; set; } = new List<Versenyzok>();
}
