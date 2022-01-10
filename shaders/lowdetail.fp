void main() 
{
	FragColor = texture(InputTexture, vec2( (floor(TexCoord.x * 400) + 0.25) / 400, (floor(TexCoord.y * 640) + 0.5) / 640));
}