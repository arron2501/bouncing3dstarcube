unit Utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    StaticButton: TRadioButton;
    RSZButton: TRadioButton;
    RSYButton: TRadioButton;
    RSXButton: TRadioButton;
    RotasiButton: TButton;
    StopButton: TButton;
    Timer1: TTimer;
    GambarButton: TButton;
    Image: TImage;
    TrackBar: TTrackBar;
    procedure FormShow(Sender: TObject);
    procedure GambarButtonClick(Sender: TObject);
    procedure RotasiButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

var
   X : array[1..8] of Double;
   Y : array[1..8] of Double;
   Z : array[1..8] of Double;
   Xa : array[1..8] of Double;
   Ya : array[1..8] of Double;
   Za : array[1..8] of Double;
   Xp : array[1..8] of Double;
   Yp : array[1..8] of Double;
   Px, Py : integer;
   Atas : array[1..8] of Boolean;
   Kanan : array[1..8] of Boolean;
   SudutRad, R, Tx, Ty, Tz, Temp, Tempa, PivotX, PivotY, PivotZ : Double;

procedure TForm1.FormShow(Sender: TObject);
begin
     Px := Image.Width div 2;
     Py := Image.Height div 2;
     StopButtonClick(Sender);
end;

procedure TForm1.GambarButtonClick(Sender: TObject);
var
   i : integer;
begin
   if sender = GambarButton then
   begin
     X[1] := -52.5;
     X[2] := -52.5;
     X[3] := 47.5;
     X[4] := 47.5;
     X[5] := -52.5;
     X[6] := -52.5;
     X[7] := 47.5;
     X[8] := 47.5;
     Xa[1] := -35;
     Xa[2] := 0;
     Xa[3] := 35;
     Xa[4] := -52.5;
     Xa[5] := 52.5;

     Y[1] := 47.5;
     Y[2] := 47.5;
     Y[3] := 47.5;
     Y[4] := 47.5;
     Y[5] := -52.5;
     Y[6] := -52.5;
     Y[7] := -52.5;
     Y[8] := -52.5;
     Ya[1] := -35;
     Ya[2] := 35;
     Ya[3] := -35;
     Ya[4] := 10.5;
     Ya[5] := 10.5;

     Z[1] := -52.5;
     Z[2] := 47.5;
     Z[3] := 47.5;
     Z[4] := -52.5;
     Z[5] := -52.5;
     Z[6] := 47.5;
     Z[7] := 47.5;
     Z[8] := -52.5;
   end;

   Image.Canvas.Pen.Style := psSolid;
   Image.Canvas.Pen.Color := clBlack;
   Image.Canvas.MoveTo(round(Px+X[8]), round(Py-Y[8]));

   for i := 1 to 8 do
   begin
     Xp[i] := round(X[i] + (Z[i] / 1.732050808) * 0.707106781);
     Yp[i] := round(Y[i] + (Z[i] / 1.732050808) * 0.707106781);
   end;

   Image.Canvas.Pen.Color := ClRed;
   Image.Canvas.Pen.Style := psSolid;
   Image.Canvas.MoveTo(round(Px+Xp[4]), round(Py-Yp[4]));
   for i := 1 to 4 do
   begin
     Image.Canvas.LineTo(round(Px+Xp[i]), round(Py-Yp[i]));
   end;

   Image.Canvas.Pen.Color := ClGreen;
   Image.Canvas.Pen.Style := psSolid;
   Image.Canvas.MoveTo(round(Px+Xp[8]), round(Py-Yp[8]));
   for i := 5 to 8 do
   begin
     Image.Canvas.LineTo(round(Px+Xp[i]), round(Py-Yp[i]));
   end;

   Image.Canvas.Pen.Color := ClBlue;
   Image.Canvas.Pen.Style := psSolid;
   for i := 1 to 2 do
   begin
     Image.Canvas.MoveTo(round(Px+Xp[i]), round(Py-Yp[i]));
     Image.Canvas.LineTo(round(Px+Xp[i+4]), round(Py-Yp[i+4]));
   end;

   Image.Canvas.Pen.Color := ClPurple;
   Image.Canvas.Pen.Style := psSolid;
   for i := 3 to 4 do
   begin
     Image.Canvas.MoveTo(round(Px+Xp[i]), round(Py-Yp[i]));
     Image.Canvas.LineTo(round(Px+Xp[i+4]), round(Py-Yp[i+4]));
   end;

  Image.Canvas.Pen.Style := psSolid;
  Image.Canvas.Pen.Color := clBlack;
  Image.Canvas.MoveTo(round(Px+Xa[5]), round(Py-Ya[5]));
  for i:=1 to 5 do
  begin
    Image.Canvas.LineTo(round(Px+Xa[i]), round(Py-Ya[i]));
  end;

  for i:=1 to 8 do
  begin
    if Atas[i] = TRUE then
       Image.Top := Image.Top - 1
    else
       Image.Top := Image.Top + 1;

    if Kanan[i] = TRUE then
       Image.Left := Image.Left + 1
    else
       Image.Left := Image.Left - 1;

    if Image.Top <= 0 then
       Atas[i] := FALSE;

    if Image.Top + Image.Height >= Form1.Height then
       Atas[i] := TRUE;

    if Image.Left <= 0 then
       Kanan[i] := TRUE;

    if Image.Left + Image.Width >= Form1.Width then
       Kanan[i] := FALSE;

  end;
  Timer1.Enabled := TRUE;
end;

procedure TForm1.StopButtonClick(Sender: TObject);
begin
  Timer1.Enabled := FALSE;
  Image.Canvas.Pen.Color := clWhite;
  Image.Canvas.Pen.Style := psSolid;
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.Brush.Style := bsSolid;
  Image.Canvas.Rectangle(0, 0, Image.Width, Image.Height);
  Image.Canvas.Pen.Color := clWhite;
  Image.Canvas.Pen.Style := psSolid;
  //Garis Vertikal
  Image.Canvas.MoveTo(Px, 0);
  Image.Canvas.LineTo(Px, Image.Height);
  //Garis Horizontal
  Image.Canvas.MoveTo(0, Py);
  Image.Canvas.LineTo(Image.Width, Py);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Interval := TrackBar.Position;
  RotasiButtonClick(sender);
end;

procedure TForm1.RotasiButtonClick(Sender: TObject);
var
   i:integer;
begin
   R := 15;
   SudutRad := R*pi/180;
   PivotX := 0;
   PivotY := 0;
   PivotZ := 0;

   if RSXButton.Checked then
   begin
     for i:=1 to 8 do
     begin
       Tx := Round(PivotX * -1);
       Ty := Round(PivotY * -1);
       Tz := Round(PivotZ * -1);
       x[i] := Round(x[i] + Tx);
       y[i] := Round(y[i] + Ty);
       z[i] := Round(z[i] + Tz);
       xa[i] := Round(xa[i] + Tx);
       ya[i] := Round(ya[i] + Ty);
       za[i] := Round(za[i] + Tz);

       temp := y[i];
       tempa := ya[i];
       x[i] := x[i];
       y[i] := y[i] * cos(SudutRad) - z[i] * sin(SudutRad);
       z[i] := temp * sin(SudutRad) + z[i] * cos(SudutRad);
       xa[i] := xa[i];
       ya[i] := ya[i] * cos(SudutRad) - za[i] * sin(SudutRad);
       za[i] := tempa * sin(SudutRad) + za[i] * cos(SudutRad);

       Tx := Round(PivotX);
       Ty := Round(PivotY);
       Tz := Round(PivotZ);
       x[i] := Round(x[i] + Tx);
       y[i] := Round(y[i] + Ty);
       z[i] := Round(z[i] + Tz);
       xa[i] := Round(xa[i] + Tx);
       ya[i] := Round(ya[i] + Ty);
       za[i] := Round(za[i] + Tz);
     end;
   end;

   if RSYButton.Checked then
   begin
     for i:=1 to 8 do
     begin
       Tx := Round(PivotX * -1);
       Ty := Round(PivotY * -1);
       Tz := Round(PivotZ * -1);
       x[i] := Round(x[i] + Tx);
       y[i] := Round(y[i] + Ty);
       z[i] := Round(z[i] + Tz);
       xa[i] := Round(xa[i] + Tx);
       ya[i] := Round(ya[i] + Ty);
       za[i] := Round(za[i] + Tz);

       temp := x[i];
       tempa := xa[i];
       x[i] := x[i] * cos(SudutRad) - z[i] * sin(SudutRad);
       y[i] := y[i];
       z[i] := temp * sin(SudutRad) + z[i] * cos(SudutRad);
       xa[i] := xa[i] * cos(SudutRad) - za[i] * sin(SudutRad);
       ya[i] := ya[i];
       za[i] := tempa * sin(SudutRad) + za[i] * cos(SudutRad);

       Tx := Round(PivotX);
       Ty := Round(PivotY);
       Tz := Round(PivotZ);
       x[i] := Round(x[i] + Tx);
       y[i] := Round(y[i] + Ty);
       z[i] := Round(z[i] + Tz);
       xa[i] := Round(xa[i] + Tx);
       ya[i] := Round(ya[i] + Ty);
       za[i] := Round(za[i] + Tz);
     end;
   end;

   if RSZButton.Checked then
   begin
     for i:=1 to 8 do
     begin
       Tx := Round(PivotX * -1);
       Ty := Round(PivotY * -1);
       Tz := Round(PivotZ * -1);
       x[i] := Round(x[i] + Tx);
       y[i] := Round(y[i] + Ty);
       z[i] := Round(z[i] + Tz);
       xa[i] := Round(xa[i] + Tx);
       ya[i] := Round(ya[i] + Ty);
       za[i] := Round(za[i] + Tz);

       temp := x[i];
       tempa := xa[i];
       x[i] := x[i] * cos(SudutRad) - y[i] * sin(SudutRad);
       y[i] := temp * sin(SudutRad) + y[i] * cos(SudutRad);
       z[i] := z[i];
       xa[i] := xa[i] * cos(SudutRad) - ya[i] * sin(SudutRad);
       ya[i] := tempa * sin(SudutRad) + ya[i] * cos(SudutRad);
       za[i] := za[i];

       Tx := Round(PivotX);
       Ty := Round(PivotY);
       Tz := Round(PivotZ);
       x[i] := Round(x[i] + Tx);
       y[i] := Round(y[i] + Ty);
       z[i] := Round(z[i] + Tz);
       xa[i] := Round(xa[i] + Tx);
       ya[i] := Round(ya[i] + Ty);
       za[i] := Round(za[i] + Tz);
     end;
   end;

   StopButtonClick(NIL);
   GambarButtonClick(NIL);
end;

end.

