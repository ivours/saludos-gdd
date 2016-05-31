using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Menu : Form
    {
        String username;
        String rol;
        Form[] formsFuncionalidades;

        public Menu()
        {
            InitializeComponent();
            formsFuncionalidades = new Form[9];
            this.asignarVisibilidadYNombresABotones();
        }

        private void button0_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(0);
            formsFuncionalidades[0].Visible = true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(1);
            formsFuncionalidades[1].Visible = true;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(2);
            formsFuncionalidades[2].Visible = true;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(3);
            formsFuncionalidades[3].Visible = true;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(4);
            formsFuncionalidades[4].Visible = true;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(5);
            formsFuncionalidades[5].Visible = true;
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(6);
            formsFuncionalidades[6].Visible = true;
        }

        private void button7_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(7);
            formsFuncionalidades[7].Visible = true;
        }

        private void button8_Click(object sender, EventArgs e)
        {
            this.asignarFuncionalidadAlBoton(8);
            formsFuncionalidades[8].Visible = true;
        }

        private List<String> getFuncionalidadesRol(String nombreRol)
        {
            List<String> funcionalidadesRol = new List<String>();
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getFuncionalidadesRol(@nombreRol)";
            consulta.Parameters.Add(new SqlParameter(@nombreRol, nombreRol));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            while (reader.Read())
                funcionalidadesRol.Add((String)reader.GetValue(0));

            return funcionalidadesRol;
        }

        private void asignarFuncionalidadAlBoton(int nroBoton)
        {
            List<String> funcionalidades = new List<String>();
            funcionalidades.Add("Vender");
            funcionalidades.Add("Historial de cliente");
            funcionalidades.Add("ABM Roles");
            funcionalidades.Add("Comprar/Ofertar");

            switch (funcionalidades[nroBoton])
            {
                case "Vender":
                    formsFuncionalidades[nroBoton] = new Generar_Publicación.Principal();
                    break;

                case "Comprar/Ofertar":
                    formsFuncionalidades[nroBoton] = new ComprarOfertar.ListadoPublicaciones();
                    break;

                case "Historial de cliente":
                    formsFuncionalidades[nroBoton] = new Historial_Cliente.HistorialCliente();
                    break;

                case "Calificar al vendedor":
                    formsFuncionalidades[nroBoton] = new Calificar.Calificar();
                    break;

                case "Consulta de facturas":
                    formsFuncionalidades[nroBoton] = new Facturas.Listado();
                    break;

                case "Listado estadístico":
                    formsFuncionalidades[nroBoton] = new Listado_Estadistico.ListadoEstadistico();
                    break;

                case "ABM Roles":
                    formsFuncionalidades[nroBoton] = new ABM_Rol.Principal();
                    break;

                case "ABM Usuarios":
                    formsFuncionalidades[nroBoton] = new ABM_Usuario.Principal();
                    break;

                case "ABM Visibilidades":
                    formsFuncionalidades[nroBoton] = new ABM_Visibilidad.Principal();
                    break;
            }
        }

        private void asignarVisibilidadYNombresABotones()
        {
            //List<String> funcionalidades = this.getFuncionalidadesRol(rol);
            List<String> funcionalidades = new List<String>();
            funcionalidades.Add("Vender");
            funcionalidades.Add("Historial de cliente");
            funcionalidades.Add("ABM Roles");
            funcionalidades.Add("Comprar/Ofertar");

            List<Button> botones = new List<Button>();
            botones.Add(button0);
            botones.Add(button1);
            botones.Add(button2);
            botones.Add(button3);
            botones.Add(button4);
            botones.Add(button5);
            botones.Add(button6);
            botones.Add(button7);
            botones.Add(button8);

            for (int i = 0; i < funcionalidades.Count(); i++)
            {
                botones[i].Text = funcionalidades[i];
                botones[i].Visible = true;
            }
        }
        

        private void Menu_Load(object sender, EventArgs e)
        {

        }

    }
}
