using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Juhász_Zsuzsanna_backend.Models;
using System.Text.Json;

namespace Juhász_Zsuzsanna_backend.Controllers
{
    [Route("api")]
    [ApiController]
    public class VersenyzokController : ControllerBase
    {
        [HttpGet("GetVesrsenyzoNev")]
        public IActionResult Get(string versenyzoNev)
        {
            try
            {
                using (var context = new UszoebContext())
                {
                    var response = context.Versenyzoks.Include(f => f.Szamoks).Include(f => f.Orszag).FirstOrDefault(f => f.Nev == versenyzoNev);
                    if (response != null)
                    {
                        return Ok(response);
                    }
                    else
                    {
                        return StatusCode(400, response);
                    }
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }

        [HttpGet("GetVesrsenyzokSzama")]
        public IActionResult Get()
        {
            try
            {
                List<Versenyzok> versenyzoks = new List<Versenyzok>();
                using (var context = new UszoebContext())
                {
                    versenyzoks = context.Versenyzoks.ToList();
                    if (versenyzoks != null)
                    {
                        return Ok(JsonSerializer.Serialize(versenyzoks.Count));
                    }
                    else
                    {
                        return StatusCode(400, "Error");
                    }
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("AddVersenyzo/{UID}")]
        public IActionResult Post(string UID, Versenyzok versenyzo)
        {
            try
            {
                using (var context = new UszoebContext()) 
                {
                    if (UID == Program.UID)
                    {
                        Versenyzok v = new Versenyzok();
                        v.Nem = versenyzo.Nem;
                        v.Orszagid = versenyzo.Orszagid;
                        v.Nev = versenyzo.Nev; 
                        context.Add(v);
                        context.SaveChanges();  
                        return StatusCode(StatusCodes.Status201Created,"Versenyző hozzáadása sikeresen megtörtént.");
                    }
                    else 
                    {
                        return StatusCode(StatusCodes.Status401Unauthorized,"Nincs jogosultsága új versenyző felvételéhez!");
                    }
                }
            }
            catch(Exception ex) 
            {
                return StatusCode(StatusCodes.Status400BadRequest, ex.Message);
            }
        }

        [HttpPut("UpdateVersenyzo/{UID}")]
        public IActionResult Put(string UID, Versenyzok versenyzo)
        {
            try
            {
                using (var context = new UszoebContext())
                {
                    if (UID == Program.UID)
                    {
                        Versenyzok v = new Versenyzok();
                        v.Id = versenyzo.Id;
                        v.Nem = versenyzo.Nem;
                        v.Orszagid = versenyzo.Orszagid;
                        v.Nev = versenyzo.Nev;
                        context.Update(v);
                        context.SaveChanges();
                        return StatusCode(StatusCodes.Status200OK, "Versenyző adatainak módosítása sikeresen megtörtént");
                    }
                    else
                    {
                        return StatusCode(StatusCodes.Status401Unauthorized, "Nincs jogosultsága a versenyzők adatainak a módosításához!");
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status400BadRequest, ex.Message);
            }
        }

        [HttpDelete("DeleteVersenyzo/{UID}")]
        public IActionResult Delete(string UID, Versenyzok versenyzo)
        {
            try
            {
                using (var context = new UszoebContext())
                {
                    if (UID == Program.UID)
                    {
                        Versenyzok v = new Versenyzok { Id=versenyzo.Id};
                        context.Remove(v);
                        context.SaveChanges();
                        return StatusCode(StatusCodes.Status204NoContent,"Versenyző adatainak a törlése sikeresen megtörtént!");
                    }
                    else
                    {
                        return StatusCode(StatusCodes.Status401Unauthorized, "Nincs jogosultsága a versenyzők adatainak a törléséhez!");
                    }
                }
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status400BadRequest, ex.Message);
            }
        }



    }
}
