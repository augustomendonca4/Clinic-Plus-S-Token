unit ClinicPlus.Form;

interface

uses FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Layouts, FMX.ListBox,
  FMX.MultiView, FMX.Objects, FMX.ListView, FMX.Controls, FMX.TabControl,
  FMX.StdCtrls, FMX.Controls.Presentation, System.Classes, FMX.Types, FMX.Forms,
  System.SysUtils, Vcl.Dialogs,
  System.JSON, FMX.Edit;

type
  TClinicPlusForm = class(TForm)
    TopRCT: TRectangle;
    MenuBTN: TButton;
    Label1: TLabel;
    AtualizarBTN: TButton;
    layout: TRectangle;
    ScheduleLYT: TLayout;
    SchedulePTH: TPath;
    HomeLYT: TLayout;
    HomePTH: TPath;
    HistoryLYT: TLayout;
    HistoryPTH: TPath;
    AnimeLYT: TLayout;
    AnimeRCT: TRectangle;
    MultiView1: TMultiView;
    MenuLST: TListBox;
    ContentTBC: TTabControl;
    ScheduleTBC: TTabItem;
    HomeTBC: TTabItem;
    HistoryTBC: TTabItem;
    ScheduleLTV: TListView;
    HistoryLTV: TListView;
    Layout1: TLayout;
    Circle1: TCircle;
    NameLBL: TLabel;
    CPFLBL: TLabel;
    ClienteMTB: TFDMemTable;
    AgendamentoMTB: TFDMemTable;
    HistoricoMTB: TFDMemTable;
    ClienteMTBidcliente: TAutoIncField;
    ClienteMTBnome: TStringField;
    ClienteMTBcpf: TStringField;
    ClienteMTBnascimento: TDateTimeField;
    ClienteMTBfoto: TBlobField;
    AgendamentoMTBidagendamento: TAutoIncField;
    AgendamentoMTBidfuncionario: TIntegerField;
    AgendamentoMTBidcliente: TIntegerField;
    AgendamentoMTBidlocal: TIntegerField;
    AgendamentoMTBidadmin: TIntegerField;
    AgendamentoMTBdata_agendamento: TDateField;
    AgendamentoMTBhora_agendamento: TTimeField;
    AgendamentoMTBdata_atendimento: TDateField;
    AgendamentoMTBhora_atendimento: TTimeField;
    AgendamentoMTBfg_status: TStringField;
    AgendamentoMTBprofissional: TStringField;
    AgendamentoMTBpaciente: TStringField;
    AgendamentoMTBlocal: TStringField;
    HistoricoMTBidagendamento: TAutoIncField;
    HistoricoMTBidfuncionario: TIntegerField;
    HistoricoMTBidcliente: TIntegerField;
    HistoricoMTBidlocal: TIntegerField;
    HistoricoMTBidadmin: TIntegerField;
    HistoricoMTBdata_confirmacao: TDateTimeField;
    HistoricoMTBdata_agendamento: TDateField;
    HistoricoMTBhora_agendamento: TTimeField;
    HistoricoMTBdata_atendimento: TDateField;
    HistoricoMTBhora_atendimento: TTimeField;
    HistoricoMTBdata_cadastro: TDateTimeField;
    AgendamentoMTBdata_confirmacao: TDateTimeField;
    AgendamentoMTBdata_cadastro: TDateTimeField;
    HistoricoMTBfg_status: TStringField;
    HistoricoMTBprofissional: TStringField;
    HistoricoMTBpaciente: TStringField;
    HistoricoMTBlocal: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    Label2: TLabel;
    Label3: TLabel;
    IDEDT: TEdit;
    CPFEDT: TEdit;
    Label4: TLabel;
    EntrarBTN: TButton;
    LoginFotoCIR: TCircle;
    procedure ScheduleLYTClick(Sender: TObject);
    procedure HistoryLYTClick(Sender: TObject);
    procedure HomeLYTClick(Sender: TObject);
    procedure AtualizarBTNClick(Sender: TObject);
    procedure ScheduleLTVUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ScheduleLTVButtonClick(const Sender: TObject;
      const AItem: TListItem; const AObject: TListItemSimpleControl);
    procedure FormCreate(Sender: TObject);
    procedure EntrarBTNClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetAgendamentoAtivo(const AToken: String);
    procedure GetHistorico(const AToken: String);
    procedure GetCliente(const AToken: String);
    procedure LoadCliente(const AToken: String);
    procedure ChangeSchedule(const AID: Integer; JSON: TJSONObject);
    procedure Login(const ID, CPF: String);
  end;

var
  ClinicPlusForm: TClinicPlusForm;
  // UserID: Integer;
  Token: String;

const
  // EnderecoServidor = 'http://192.168.0.110:9000/';
  // EnderecoServidor = 'http://192.168.137.1:9000/';
  EnderecoServidor = 'http://localhost:9000/';
  //Token = 'bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTY4OTU0NDgs'
    //+ 'ImV4cCI6MTcxNjk4MTg0OCwiaXNzIjoibG9jYWxob3N0IiwiaWQiOiIxIiwibm9tZSI6' +
    //'IkRFTklMU09OIE1PUklMSU4iLCJjcGYiOiI0NDQuNDQ0LjQ0NC00NCIsIm5hc2NpbWVu' +
    //'dG8iOiIxOFwvMTBcLzE5NzIifQ.v1vjMjl_G1XDGLiHn0h_au2h9FDpQmMKxEkaQHHilSQ';

implementation

uses FMX.Ani,
  FMX.Graphics,
  RESTRequest4D,
  DataSet.Serialize,
  DataSet.Serialize.Adapter.RESTRequest4D,
  System.Threading;

{$R *.fmx}

procedure TClinicPlusForm.GetAgendamentoAtivo(const AToken: String);
begin
  TRequest.New.BaseURL(EnderecoServidor + 'agendamento')
    .AddHeader('Authorization', AToken, [poDoNotEncode])
    .AddParam('fg_status', 'a')
  // .AddParam('idcliente', IntToStr(User))
    .Adapters(TDataSetSerializeAdapter.New(AgendamentoMTB))
    .Accept('application/json').Get;
end;

procedure TClinicPlusForm.GetHistorico(const AToken: String);
begin
  TRequest.New.BaseURL(EnderecoServidor + 'agendamento')
    .AddHeader('Authorization', AToken, [poDoNotEncode])
  // .AddParam('idcliente', IntToStr(User))
    .Adapters(TDataSetSerializeAdapter.New(HistoricoMTB))
    .Accept('application/json').Get
end;

procedure TClinicPlusForm.GetCliente(const AToken: String);
begin
  TRequest.New.BaseURL(EnderecoServidor + 'cliente')
  // .ResourceSuffix(IntToStr(ID))
    .AddHeader('Authorization', AToken, [poDoNotEncode])
    .Adapters(TDataSetSerializeAdapter.New(ClienteMTB))
    .Accept('application/json').Get
end;

procedure TClinicPlusForm.LoadCliente(const AToken: String);
var
  FotoStream: TMemoryStream;
  BrushBmp: TBrushBitmap;
begin
  // GetCliente(ID);
  GetCliente(AToken);
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      NameLBL.Text := ClienteMTBnome.AsString;
      CPFLBL.Text := ClienteMTBcpf.AsString;

      FotoStream := TMemoryStream.Create;
      BrushBmp := TBrushBitmap.Create;

      try
        ClienteMTBfoto.SaveToStream(FotoStream);
        BrushBmp.Bitmap.LoadFromStream(FotoStream);
        BrushBmp.WrapMode := TWrapMode.TileStretch;
        Circle1.Fill.Bitmap.Assign(BrushBmp);
      finally
        FotoStream.Free;
        BrushBmp.Free;
      end;
    end);
end;

procedure TClinicPlusForm.AtualizarBTNClick(Sender: TObject);
begin
  TTask.Run(
    procedure
    begin
      GetAgendamentoAtivo(Token);
      GetHistorico(Token);
      LoadCliente(Token);
    end);
end;

procedure TClinicPlusForm.ChangeSchedule(const AID: Integer; JSON: TJSONObject);
begin
  TRequest.New.BaseURL(EnderecoServidor + 'agendamento')
    .ResourceSuffix(IntToStr(AID)).AddBody(JSON, false)
    .Accept('application/json').Put;
end;

procedure TClinicPlusForm.FormCreate(Sender: TObject);
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition :=
    TCaseNameDefinition.cndNone;
  AnimeRCT.Position.X := HomeLYT.Position.X;
  // UserID := 1;
  // AtualizarBTNClick(nil);

  // TTask.Run(
  // procedure
  // begin
  // LoadCliente(Token);
  // GetAgendamentoAtivo(Token);
  // GetHistorico(Token);
  // end);
  MultiView1.ShowMaster;
  IDEDT.SetFocus;
end;

procedure TClinicPlusForm.HistoryLYTClick(Sender: TObject);
begin
  TAnimator.AnimateFloat(AnimeRCT, 'position.x', HistoryLYT.Position.X, 0.5,
    TAnimationType.Out, TInterpolationType.Bounce);

  ContentTBC.setActiveTabWithTransitionAsync(HistoryTBC, TTabTransition.Slide,
    TTabTransitionDirection.Reversed, nil);
end;

procedure TClinicPlusForm.ScheduleLTVButtonClick(const Sender: TObject;
const AItem: TListItem; const AObject: TListItemSimpleControl);
var
  JSON: TJSONObject;
begin
  if AObject.Name.ToLower = 'confirmabutton' then
  begin
    AgendamentoMTB.Edit;
    AgendamentoMTBfg_status.AsString := 'C';
    AgendamentoMTBdata_confirmacao.Value := Now;
    AgendamentoMTB.Post;
    JSON := AgendamentoMTB.ToJSONObject();
    ChangeSchedule(AgendamentoMTBidagendamento.Value, JSON);
    JSON.Free;
  end;

  if AObject.Name.ToLower = 'cancelabutton' then
  begin
    AgendamentoMTB.Edit;
    AgendamentoMTBfg_status.AsString := 'I';
    AgendamentoMTBdata_confirmacao.Value := Now;
    AgendamentoMTB.Post;
    JSON := AgendamentoMTB.ToJSONObject();
    ChangeSchedule(AgendamentoMTBidagendamento.Value, JSON);
    JSON.Free;
  end;

  TTask.Run(
    procedure
    begin
      Sleep(50);
      AgendamentoMTB.EmptyDataSet;
      HistoricoMTB.EmptyDataSet;
      GetAgendamentoAtivo(Token);
      GetHistorico(Token);
    end);
end;

procedure TClinicPlusForm.ScheduleLTVUpdateObjects(const Sender: TObject;
const AItem: TListViewItem);
begin
  AItem.Objects.DrawableByName('ConfirmaButton').Height := 37;
  AItem.Objects.DrawableByName('CancelaButton').Height := 37;
end;

procedure TClinicPlusForm.ScheduleLYTClick(Sender: TObject);
begin
  TAnimator.AnimateFloat(AnimeRCT, 'position.x', ScheduleLYT.Position.X, 0.5,
    TAnimationType.Out, TInterpolationType.Bounce);

  ContentTBC.setActiveTabWithTransitionAsync(ScheduleTBC, TTabTransition.Slide,
    TTabTransitionDirection.Reversed, nil);
end;

procedure TClinicPlusForm.HomeLYTClick(Sender: TObject);
var
  TabDirection: TTabTransitionDirection;
begin
  if ContentTBC.ActiveTab.Index > HomeTBC.Index then
  begin
    TabDirection := TTabTransitionDirection.Reversed;
  end
  else
  begin
    TabDirection := TTabTransitionDirection.normal;
  end;

  TAnimator.AnimateFloat(AnimeRCT, 'position.x', HomeLYT.Position.X, 0.5,
    TAnimationType.Out, TInterpolationType.Bounce);

  ContentTBC.setActiveTabWithTransitionAsync(HomeTBC, TTabTransition.Slide,
    TTabTransitionDirection.Reversed, nil);
end;

procedure TClinicPlusForm.Login(const ID, CPF: String);
var
  JSON: TJSONObject;
  Resposta: IResponse;
begin
  JSON := TJSONObject.Create;
  try
    JSON.AddPair('idcliente', ID);
    JSON.AddPair('cpf', CPF);
    try
      Resposta := TRequest.New.BaseURL(EnderecoServidor + 'token')
        .AddBody(JSON, false).Accept('application/json').Post;
      if Resposta.StatusCode = 200 then
      begin
        Token := 'Bearer ' + Resposta.Content;
      end
      else
      begin
        ShowMessage('Falha na autenticação: ' + Resposta.Content);
      end;
    except
      On E: Exception do
      begin
        ShowMessage('Falha no login: ' + E.Message);
      end;
    end;
  finally
    JSON.Free;
  end;
end;

procedure TClinicPlusForm.EntrarBTNClick(Sender: TObject);
begin
  if (IDEDT.Text = '') or (CPFEDT.Text = '') then
    raise Exception.Create('Informe o ID e o CPF');

  TTask.Run(
    procedure
    begin
      Login(IDEDT.Text, CPFEDT.Text);
      LoadCliente(Token);
      GetAgendamentoAtivo(Token);
      GetHistorico(Token);

      TThread.Synchronize(TThread.Current,
        procedure
        begin
          LoginFotoCIR.Fill.Bitmap.Assign(Circle1.Fill.Bitmap);
          MultiView1.HideMaster;
        end);
    end);
end;

end.
