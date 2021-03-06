"""empty message

Revision ID: efa91ad1eabc
Revises: 
Create Date: 2017-08-31 22:31:47.998915

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'efa91ad1eabc'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('category',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('name', sa.String(length=100), nullable=True),
    sa.Column('slug', sa.String(length=100), nullable=True),
    sa.Column('is_menu', sa.Integer(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('name')
    )
    op.create_table('contact',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('firstname', sa.String(length=255), nullable=True),
    sa.Column('lastname', sa.String(length=255), nullable=True),
    sa.Column('email', sa.String(length=255), nullable=True),
    sa.Column('comment', sa.Text(), nullable=True),
    sa.Column('published_at', sa.TIMESTAMP(), server_default=sa.text(u'CURRENT_TIMESTAMP'), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('email')
    )
    op.create_table('email',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('email', sa.String(length=255), nullable=True),
    sa.Column('firstname', sa.String(length=255), nullable=True),
    sa.Column('lastname', sa.String(length=255), nullable=True),
    sa.Column('published_at', sa.TIMESTAMP(), server_default=sa.text(u'CURRENT_TIMESTAMP'), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('email')
    )
    op.create_table('group',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('name', sa.String(length=255), nullable=True),
    sa.Column('published_at', sa.TIMESTAMP(), server_default=sa.text(u'CURRENT_TIMESTAMP'), nullable=True),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('member',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('name', sa.String(length=50), nullable=True),
    sa.Column('slug', sa.String(length=50), nullable=True),
    sa.Column('feature_image', sa.String(length=300), nullable=True),
    sa.Column('possition', sa.String(length=300), nullable=True),
    sa.Column('detail', sa.String(length=1000), nullable=True),
    sa.Column('created_at', sa.TIMESTAMP(), server_default=sa.text(u'CURRENT_TIMESTAMP'), nullable=True),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('page',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('title', sa.String(length=255), nullable=True),
    sa.Column('slug', sa.String(length=255), nullable=True),
    sa.Column('description', sa.Text(), nullable=True),
    sa.Column('published_at', sa.TIMESTAMP(), server_default=sa.text(u'CURRENT_TIMESTAMP'), nullable=True),
    sa.Column('is_menu', sa.Integer(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('title')
    )
    op.create_table('user_member',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('name', sa.String(length=50), nullable=True),
    sa.Column('email', sa.String(length=100), nullable=True),
    sa.Column('password', sa.String(length=600), nullable=True),
    sa.Column('password2', sa.String(length=200), nullable=True),
    sa.Column('created_at', sa.TIMESTAMP(), server_default=sa.text(u'CURRENT_TIMESTAMP'), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('email')
    )
    op.create_table('emailgroup',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('email_id', sa.Integer(), nullable=True),
    sa.Column('group_id', sa.Integer(), nullable=True),
    sa.Column('published_at', sa.TIMESTAMP(), server_default=sa.text(u'CURRENT_TIMESTAMP'), nullable=True),
    sa.ForeignKeyConstraint(['email_id'], ['email.id'], ),
    sa.ForeignKeyConstraint(['group_id'], ['group.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('post',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('title', sa.String(length=255), nullable=True),
    sa.Column('description', sa.Text(), nullable=True),
    sa.Column('feature_image', sa.String(length=300), nullable=True),
    sa.Column('slug', sa.String(length=255), nullable=True),
    sa.Column('category_id', sa.Integer(), nullable=True),
    sa.Column('user_id', sa.Integer(), nullable=True),
    sa.Column('published_at', sa.TIMESTAMP(), server_default=sa.text(u'CURRENT_TIMESTAMP'), nullable=True),
    sa.Column('views', sa.Integer(), nullable=True),
    sa.Column('images', sa.Text(), nullable=True),
    sa.Column('price', sa.Integer(), nullable=True),
    sa.Column('date', sa.String(length=200), nullable=True),
    sa.Column('participants', sa.String(length=200), nullable=True),
    sa.Column('cost', sa.String(length=200), nullable=True),
    sa.ForeignKeyConstraint(['category_id'], ['category.id'], ),
    sa.ForeignKeyConstraint(['user_id'], ['user_member.id'], ),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('slug'),
    sa.UniqueConstraint('title')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('post')
    op.drop_table('emailgroup')
    op.drop_table('user_member')
    op.drop_table('page')
    op.drop_table('member')
    op.drop_table('group')
    op.drop_table('email')
    op.drop_table('contact')
    op.drop_table('category')
    # ### end Alembic commands ###
